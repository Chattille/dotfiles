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
