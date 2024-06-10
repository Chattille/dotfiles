local enabled_fts = {
    'bash',
    'javascript',
    'lua',
    'python',
    'sh',
    'zsh',
}
local cmdmap = {
    bash = 'bash',
    javascript = 'node',
    lua = 'lua',
    python = 'python',
    sh = 'sh',
    zsh = 'zsh',
}

return {
    condition = {
        callback = function(opts)
            return vim.tbl_contains(enabled_fts, opts.filetype)
        end,
    },
    generator = function(opts, callback)
        local fpath = vim.api.nvim_buf_get_name(0)
        local fname = vim.fn.expand '%:t'
        local fperm = vim.fn.getfperm(fpath)
        local isexecutable = fperm:sub(3, 3) == 'x'

        if isexecutable then
            callback {
                {
                    name = '@execute ' .. fname,
                    tags = { 'RUN', 'DEFAULT' },
                    builder = function()
                        return { name = 'Execute ' .. fname, cmd = fpath }
                    end,
                },
            }
        else
            local cmd = cmdmap[opts.filetype]
            callback {
                {
                    name = '@run with ' .. cmd,
                    tags = { 'RUN', 'DEFAULT' },
                    builder = function()
                        return {
                            name = 'Run with '
                                .. cmd:sub(1, 1):upper()
                                .. cmd:sub(2),
                            cmd = '/bin/env',
                            args = { cmd, fname },
                        }
                    end,
                },
            }
        end
    end,
}
