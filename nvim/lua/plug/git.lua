return {
    'lewis6991/gitsigns.nvim',
    cond = function()
        return vim.fs.root(require('util.files').buf_get_real_base(), '.git')
                and true
            or false
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

            vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#89b4fa' })
        end,
    },
    event = 'VeryLazy',
}
