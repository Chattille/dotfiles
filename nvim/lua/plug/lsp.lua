return {
    -- LSP config
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'williamboman/mason.nvim' },
        config = function()
            require 'conf.lspconf'
        end,
        ft = {
            'c',
            'cpp',
            'css',
            'html',
            'javascript',
            'json',
            'jsonc',
            'less',
            'lua',
            'python',
            'scss',
            'typescript',
        },
    },

    -- LSP installer
    {
        'williamboman/mason.nvim',
        opts = {
            ui = {
                border = 'rounded',
                icons = {
                    package_installed = '󰧞',
                    package_pending = '󰺕',
                    package_uninstalled = '',
                },
                keymaps = {
                    toggle_package_expand = '<Space>',
                    toggle_package_install_log = '<Space>',
                },
            },
        },
        cmd = {
            'Mason',
            'MasonUpdate',
            'MasonInstall',
            'MasonUninstall',
            'MasonUninstallAll',
            'MasonLog',
        },
    },

    -- diagnostics
    {
        'folke/trouble.nvim',
        opts = {
            focus = true,
            win = { padding = { left = 0 } },
            keys = { ['<Space>'] = 'jump' },
        },
        cmd = 'Trouble',
    },

    -- outline
    {
        'hedyhli/outline.nvim',
        opts = {
            outline_window = { auto_close = true },
            preview_window = { border = 'rounded' },
            symbol_folding = { autofold_depth = 3 },
            keymaps = {
                goto_location = 'o',
                peek_location = '<Space>',
                code_actions = 'ga',
            },
            providers = { priority = { 'lsp', 'markdown' } },
            symbols = {
                icon_fetcher = function(kind)
                    return require('util.icons').symbols[kind]
                end,
                filter = {
                    lua = { 'Package', exclude = true },
                },
            },
        },
        cmd = {
            'Outline',
            'OutlineClose',
            'OutlineFocus',
            'OutlineFocusCode',
            'OutlineFocusOutline',
            'OutlineFollow',
            'OutlineOpen',
            'OutlineRefresh',
            'OutlineStatus',
        },
        keys = {
            {
                '<Leader>jO',
                function()
                    require('outline').toggle()
                end,
                desc = 'Toggle document outline',
            },
        },
    },

    -- non-LSP sources
    {
        'nvimtools/none-ls.nvim',
        config = function()
            require 'conf.none_ls'
        end,
        cmd = { 'NullLsLog', 'NullLsInfo' },
        ft = {
            'lua',
        },
    },
}
