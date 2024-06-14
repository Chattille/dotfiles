local fs = require 'util.files'

local enabled_fts = { 'javascript', 'json', 'jsonc', 'typescript' }

---Get root directory of an NPM project.
---@return string? # Path to the root directory.
local function get_npm_root()
    return vim.fs.root(fs.buf_get_real_base(), 'package.json')
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
        local json = fs.load_json_file(root .. '/package.json')
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
