return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require 'conf.treesitter'
        end,
        lazy = false,
    },

    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function(opts)
            require('nvim-treesitter-textobjects').setup(opts)

            -- select
            local tsselect =
                require('nvim-treesitter-textobjects.select').select_textobject
            local select_keymaps = {
                {
                    lhs = 'af',
                    rhs = '@function.outer',
                    desc = 'Select outer function',
                },
                {
                    lhs = 'if',
                    rhs = '@function.inner',
                    desc = 'Select inner function',
                },
                {
                    lhs = 'ac',
                    rhs = '@class.outer',
                    desc = 'Select outer class',
                },
                {
                    lhs = 'ic',
                    rhs = '@class.inner',
                    desc = 'Select inner class',
                },
            }

            for _, keymap in ipairs(select_keymaps) do
                vim.keymap.set({ 'x', 'o' }, keymap.lhs, function()
                    tsselect(keymap.rhs, 'textobjects')
                end, { desc = keymap.desc })
            end

            -- move
            local tsmove = require 'nvim-treesitter-textobjects.move'
            local move_keymaps = {
                {
                    type = 'goto_next_start',
                    lhs = ']f',
                    rhs = '@function.outer',
                    desc = 'Go to the start of the next function',
                },
                {
                    type = 'goto_next_start',
                    lhs = ']c',
                    rhs = '@class.outer',
                    desc = 'Go to the start of the next class',
                },
                {
                    type = 'goto_next_end',
                    lhs = ']F',
                    rhs = '@function.outer',
                    desc = 'Go to the end of the next function',
                },
                {
                    type = 'goto_next_end',
                    lhs = ']C',
                    rhs = '@class.outer',
                    desc = 'Go to the end of the next class',
                },
                {
                    type = 'goto_previous_start',
                    lhs = '[f',
                    rhs = '@function.outer',
                    desc = 'Go to the start of the previous function',
                },
                {
                    type = 'goto_previous_start',
                    lhs = '[c',
                    rhs = '@class.outer',
                    desc = 'Go to the start of the previous class',
                },
                {
                    type = 'goto_previous_end',
                    lhs = '[F',
                    rhs = '@function.outer',
                    desc = 'Go to the end of the previous function',
                },
                {
                    type = 'goto_previous_end',
                    lhs = '[C',
                    rhs = '@class.outer',
                    desc = 'Go to the end of the previous class',
                },
            }

            for _, keymap in ipairs(move_keymaps) do
                vim.keymap.set({ 'n', 'x', 'o' }, keymap.lhs, function()
                    tsmove[keymap.type](keymap.rhs, 'textobjects')
                end, { desc = keymap.desc })
            end
        end,
        otps = {
            select = {
                selection_modes = {
                    ['@function.inner'] = 'v',
                    ['@function.outer'] = 'V',
                    ['@class.inner'] = 'v',
                    ['@class.outer'] = 'V',
                },
                include_surrounding_whitespace = true,
            },
            lsp_interop = {
                floating_preview_opts = { border = 'rounded' },
            },
        },
        ft = {
            -- all disabled: css, json, jsonc, make, query, scss, vimdoc, yaml
            --               dockerfile
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
            'vue',
        },
    },

    {
        'RRethy/nvim-treesitter-endwise',
        ft = { 'bash', 'lua', 'ruby', 'vim' },
    },
}
