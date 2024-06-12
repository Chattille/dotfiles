local buf_get_real_base = require('util.tools').buf_get_real_base

local enabled_fts = { 'javascript', 'json', 'jsonc', 'typescript' }

---Read file content.
---@param fpath string File path.
---@return string? # File content.
local function read_file(fpath)
    local fd = assert(vim.uv.fs_open(fpath, 'r', 420), 'reading file failed')
    local stat = assert(vim.uv.fs_fstat(fd), 'reading file content failed')
    local cont = vim.uv.fs_read(fd, stat.size)
    vim.uv.fs_close(fd)
    return cont
end

---Get root directory of an NPM project.
---@return string? # Path to the root directory.
local function get_npm_root()
    return vim.fs.root(buf_get_real_base(), 'package.json')
end

return {
    condition = {
        callback = function(opts)
            return vim.list_contains(enabled_fts, opts.filetype)
                and (get_npm_root() and true or false)
        end,
    },
    generator = function(_, callback)
        local root = get_npm_root()
        if not root then
            vim.notify('Root directory not found.', vim.log.levels.ERROR)
            return
        end

        -- read package.json
        local cont = read_file(root .. '/package.json')
        if not cont then
            callback {}
            return
        end

        local json =
            vim.json.decode(cont, { luanil = { object = true, array = true } })
        if not json.scripts or vim.tbl_isempty(json.scripts) then
            callback {}
            return
        end

        -- add custom scripts defined in package.json
        local templs = {}
        for cmd, _ in pairs(json.scripts) do
            table.insert(templs, {
                name = 'npm run ' .. cmd,
                tags = { 'RUN' },
                builder = function()
                    return {
                        name = 'NPM Run: ' .. cmd,
                        cmd = 'npm',
                        args = { 'run', cmd },
                    }
                end,
            })
        end

        callback(templs)
    end,
}
