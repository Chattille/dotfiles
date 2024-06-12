return {
    {
        'nvim-treesitter/nvim-treesitter',
        main = 'nvim-treesitter.configs',
        build = ':TSUpdate',
        opts = {
            highlight = { enable = true },
            textobjects = {
                select = {
                    enable = true,
                    disable = {
                        'css',
                        'json',
                        'jsonc',
                        'make',
                        'markdown_inline',
                        'query',
                        'scss',
                        'vimdoc',
                        'xml',
                    },
                    keymaps = {
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                    },
                    selection_modes = {
                        ['@function.inner'] = 'v',
                        ['@function.outer'] = 'V',
                        ['@class.inner'] = 'v',
                        ['@class.outer'] = 'V',
                    },
                    include_surrounding_whitespace = true,
                },
                move = {
                    enable = true,
                    disable = {
                        'css',
                        'json',
                        'jsonc',
                        'make',
                        'markdown_inline',
                        'query',
                        'scss',
                        'vimdoc',
                        'xml',
                    },
                    goto_next_start = {
                        [']f'] = '@function.outer',
                        [']c'] = '@class.outer',
                    },
                    goto_next_end = {
                        [']F'] = '@function.outer',
                        [']C'] = '@class.outer',
                    },
                    goto_previous_start = {
                        ['[f'] = '@function.outer',
                        ['[c'] = '@class.outer',
                    },
                    goto_previous_end = {
                        ['[F'] = '@function.outer',
                        ['[C'] = '@class.outer',
                    },
                },
                lsp_interop = {
                    enable = true,
                    disable = {
                        'bash',
                        'css',
                        'html',
                        'json',
                        'jsonc',
                        'make',
                        'markdown',
                        'markdown_inline',
                        'query',
                        'scss',
                        'vim',
                        'vimdoc',
                        'xml',
                    },
                    floating_preview_opts = { border = 'rounded' },
                    peek_definition_code = {
                        ['<Leader>js'] = '@function.outer',
                        ['<Leader>jS'] = '@class.outer',
                    },
                },
            },
            endwise = { enable = true },
        },
        ft = {
            'bash',
            'c',
            'cpp',
            'css',
            'help',
            'html',
            'javascript',
            'json',
            'jsonc',
            'lua',
            'make',
            'markdown',
            'python',
            'query',
            'scss',
            'typescript',
            'vim',
            'xml',
        },
        cmd = {
            'TSConfigInfo',
            'TSBufDisable',
            'TSBufEnable',
            'TSBufToggle',
            'TSDisable',
            'TSEditQuery',
            'TSEditQueryUserAfter',
            'TSEnable',
            'TSInstall',
            'TSInstallInfo',
            'TSInstallFromGrammar',
            'TSInstallSync',
            'TSModuleInfo',
            'TSToggle',
            'TSUninstall',
            'TSUpdate',
            'TSUpdateSync',
        },
    },

    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        ft = { -- all disabled: css, json, jsonc, make, query, scss, vimdoc
            'bash',
            'c',
            'cpp',
            'html',
            'javascript',
            'lua',
            'markdown',
            'python',
            'typescript',
            'vim',
        },
    },

    {
        'RRethy/nvim-treesitter-endwise',
        ft = { 'bash', 'lua', 'ruby', 'vim' },
    },
}
