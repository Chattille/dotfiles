local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plug', {
    change_detection = { notify = false },
    defaults = { lazy = true },
    install = { colorscheme = { 'catppuccin' } },
    performance = {
        rtp = {
            -- standard plugins disabled
            disabled_plugins = {
                'gzip',
                'netrwPlugin',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
    ui = {
        backdrop = 100,
        border = 'rounded',
        icons = {
            list = { '󰧟', '󰨕', '󰺕', '󰝣' },
            task = '󰄵 ',
        },
    },
})
