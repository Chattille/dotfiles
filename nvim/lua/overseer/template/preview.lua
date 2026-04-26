---Generate live preview builder.
---@param cwd string Working directory.
---@return function # Builder function.
local function get_builder(cwd)
    return function()
        return {
            name = 'Browser-sync',
            strategy = 'jobstart',
            cmd = 'browser-sync',
            args = {
                'start',
                '--server',
                '--watch',
                '--no-ui',
                '--cwd',
                cwd,
                '--browser',
                '/mnt/c/Program Files/BraveSoftware/Brave-Browser/Application/'
                    .. 'brave.exe',
            },
        }
    end
end

return {
    condition = {
        filetype = {
            'css',
            'html',
            'javascript',
            'less',
            'scss',
            'typescript',
        },
    },
    generator = function(opts)
        local root = vim.fs.root(opts.dir, { 'package.json', 'index.html' })

        local tags
        local name
        if
            vim.list_contains({ 'javascript', 'typescript' }, opts.filetype)
        then
            tags = { 'RUN' }
            name = 'live preview'
        else -- default for others
            tags = { 'RUN', 'DEFAULT' }
            name = '@live preview'
        end

        return {
            {
                name = name,
                tags = tags,
                builder = root and get_builder(root) or get_builder(opts.dir),
            },
            { -- for HTML only
                name = 'open in browser',
                tags = { 'RUN' },
                condition = { filetype = 'html' },
                builder = function()
                    return {
                        name = 'Open in Browser',
                        strategy = 'jobstart',
                        cmd = { 'explorer.exe', vim.fn.expand '%:t' },
                    }
                end,
            },
        }
    end,
}
