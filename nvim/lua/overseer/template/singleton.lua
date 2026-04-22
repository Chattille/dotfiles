local cmdmap = {
    bash = { 'bash' },
    javascript = { 'node' },
    lua = { 'lua' },
    python = { 'uv', 'run' },
    sh = { 'sh' },
    zsh = { 'zsh' },
}

return {
    condition = {
        filetype = {
            'bash',
            'javascript',
            'lua',
            'python',
            'sh',
            'zsh',
        },
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
            local cmds = cmdmap[opts.filetype]
            local cmdstr = cmds:concat ' '
            callback {
                {
                    name = '@run with ' .. cmdstr,
                    tags = { 'RUN', 'DEFAULT' },
                    builder = function()
                        return {
                            name = 'Run with ' .. cmdstr,
                            cmd = '/bin/env',
                            args = vim.iter({ '-S', cmds, fname })
                                :flatten()
                                :totable(),
                        }
                    end,
                },
            }
        end
    end,
}
