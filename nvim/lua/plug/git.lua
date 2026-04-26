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
            local map = function(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end
            local gs = require 'gitsigns'

            map('n', '<Leader>gg', gs.preview_hunk, 'Git preview hunk')
            map({ 'n', 'x' }, '<Leader>gs', function()
                local mode = vim.api.nvim_get_mode().mode
                if vim.tbl_contains({ 'v', 'V', '' }, mode) then
                    gs.stage_hunk {
                        vim.fn.getpos('v')[2],
                        vim.fn.getpos('.')[2],
                    }
                else
                    gs.stage_hunk()
                end
            end, 'Git un/stage hunk')
            map('n', '<Leader>gS', gs.stage_buffer, 'Git stage buffer')
            map({ 'n', 'x' }, '<Leader>gr', function()
                local mode = vim.api.nvim_get_mode().mode
                if vim.tbl_contains({ 'v', 'V', '' }, mode) then
                    gs.reset_hunk {
                        vim.fn.getpos('v')[2],
                        vim.fn.getpos('.')[2],
                    }
                else
                    gs.reset_hunk()
                end
            end, 'Git reset hunk')
            map('n', '<Leader>gR', gs.reset_buffer, 'Git reset buffer')
            map('n', '[g', function()
                gs.nav_hunk 'prev'
            end, 'Git go to previous hunk')
            map('n', ']g', function()
                gs.nav_hunk 'next'
            end, 'Git go to next hunk')

            vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#89b4fa' })
            vim.api.nvim_set_hl(0, 'GitSignsStagedChange', { fg = '#3c5f9f' })
        end,
    },
    event = 'VeryLazy',
}
