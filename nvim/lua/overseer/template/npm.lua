local fs = require 'util.files'

local cmd_tag = {
    build = 'BUILD',
    run = 'RUN',
    test = 'TEST',
}

---Get root directory of an NPM project.
---@return string? # Path to the root directory.
local function get_npm_root()
    return vim.fs.root(fs.buf_get_real_base(), 'package.json')
end

return {
    condition = {
        filetype = { 'javascript', 'json', 'jsonc', 'typescript', 'vue' },
    },
    generator = function(_, callback)
        local root = get_npm_root()
        if not root then
            callback '[Template npm] Root directory not found'
        end

        -- read package.json
        local json = fs.load_json_file(root .. '/package.json')
        if not json.scripts or vim.tbl_isempty(json.scripts) then
            callback '[Template npm] No custom scripts'
        end

        -- add custom scripts defined in package.json
        local templs = {}
        for cmd, _ in pairs(json.scripts) do
            table.insert(templs, {
                name = "run npm script '" .. cmd .. "'",
                tags = { cmd_tag[cmd] },
                builder = function()
                    return {
                        name = 'NPM Run: ' .. cmd,
                        cmd = { 'npm', 'run', '--silent', cmd },
                    }
                end,
            })
        end

        callback(templs)
    end,
}
