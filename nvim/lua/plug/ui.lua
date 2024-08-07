return {
    -- indent line
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = function()
            vim.api.nvim_set_hl(0, 'IblScopeIndent', { fg = '#4f4f5f' })
            return {
                indent = { char = '▏' },
                scope = {
                    show_start = false,
                    show_end = false,
                    highlight = 'IblScopeIndent',
                },
            }
        end,
        ft = {
            'bash',
            'c',
            'cpp',
            'css',
            'html',
            'javascript',
            'json',
            'jsonc',
            'less',
            'lua',
            'ps1',
            'ps1xml',
            'python',
            'scss',
            'typescript',
            'vue',
            'xml',
            'yaml',
            'zsh',
        },
    },

    -- bufferline
    {
        'akinsho/bufferline.nvim',
        version = '*',
        event = 'BufEnter',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require 'conf.bufline'
        end,
    },

    -- statusline
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = 'VeryLazy',
        config = function()
            require 'conf.lualine'
        end,
    },

    -- UI patch
    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
        opts = {
            input = {
                prefer_width = 0,
                mappings = {
                    i = {
                        ['<C-p>'] = 'HistoryPrev',
                        ['<C-n>'] = 'HistoryNext',
                    },
                },
            },
            select = {
                backend = { 'telescope', 'builtin' },
                builtin = {
                    show_numbers = false,
                    relative = 'cursor',
                    mappings = { q = 'Close' },
                    min_width = { 0, 0 },
                    min_height = { 0, 0 },
                },
            },
        },
    },

    -- colorization
    {
        'uga-rosa/ccc.nvim',
        config = function()
            require 'conf.ccc'
        end,
        cmd = {
            'CccPick',
            'CccConvert',
            'CccHighlighterEnable',
            'CccHighlighterToggle',
            'CccHighlighterDisable',
        },
        ft = {
            'css',
            'help',
            'html',
            'javascript',
            'less',
            'lua',
            'scss',
            'typescript',
            'vue',
        },
    },
}
