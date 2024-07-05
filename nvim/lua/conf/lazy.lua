local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
vim.opt.rtp:prepend(lazypath)

-- bootstrap
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable',
        lazyrepo,
        lazypath,
    }
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

-- setup
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
