require('catppuccin').setup {
    compile_path = vim.fn.stdpath 'cache' .. '/catppuccin',
    custom_highlights = function()
        return {
            -- make float window transparent
            NormalFloat = { bg = 'NONE' },
        }
    end,
}

vim.cmd.colorscheme 'catppuccin'

-- }}} aesthetic adjustments {{{

vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#89b4fa', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'FloatTitle', { fg = '#a6adc8', bg = 'NONE' })
