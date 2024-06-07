return {
    'lewis6991/gitsigns.nvim',
    cond = function()
        local bufname = vim.api.nvim_buf_get_name(0)
        local realpath = vim.uv.fs_realpath(bufname)
        local start

        if bufname == '' then -- [No Name]
            start = vim.uv.cwd()
        elseif not realpath then -- new file
            start = bufname
        else
            start = realpath -- current file or symlink
        end

        local gitdir =
            require('util.tools').get_root('.git', start, 'directory')
        return gitdir and true or false
    end,
    opts = {
        preview_config = { border = 'rounded' },
        on_attach = function(bufnr)
            local map = function(lhs, rhs, desc)
                vim.keymap.set('n', lhs, rhs, { buffer = bufnr, desc = desc })
            end
            local gs = require 'gitsigns'

            map('<Leader>gg', gs.preview_hunk, 'Git preview hunk')
            map('<Leader>gs', gs.stage_hunk, 'Git stage hunk')
            map('<Leader>gS', gs.stage_buffer, 'Git stage buffer')
            map('<Leader>gu', gs.undo_stage_hunk, 'Git undo stage hunk')
            map('<Leader>gr', gs.reset_hunk, 'Git reset hunk')
            map('<Leader>gR', gs.reset_buffer, 'Git reset buffer')
            map('[g', function()
                gs.nav_hunk 'prev'
            end, 'Git go to previous hunk')
            map(']g', function()
                gs.nav_hunk 'next'
            end, 'Git go to next hunk')
        end,
    },
    event = 'VeryLazy',
}
