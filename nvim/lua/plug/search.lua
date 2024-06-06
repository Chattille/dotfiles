return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'prochri/telescope-all-recent.nvim',
        },
        config = function()
            require 'conf.telescope'
        end,
        cmd = 'Telescope',
        keys = {
            {
                '<Leader>ff',
                function()
                    require('telescope.builtin').find_files()
                end,
                desc = 'Telescope: find files',
            },
            {
                '<Leader>fg',
                function()
                    require('telescope.builtin').live_grep()
                end,
                desc = 'Telescope: live grep',
            },
            {
                '<Leader>fl',
                function()
                    require('telescope.builtin').current_buffer_fuzzy_find()
                end,
                desc = 'Telescope: current buffer',
            },
            {
                '<Leader>fc',
                function()
                    require('telescope.builtin').command_history()
                end,
                desc = 'Telescope: command history',
            }
        },
    },

    {
        'nvim-telescope/telescope-fzf-native.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' },
        build = 'make',
    },

    {
        'prochri/telescope-all-recent.nvim',
        dependencies = { 'kkharji/sqlite.lua' },
        opts = {
            default = { sorting = 'frecency' },
            pickers = {
                live_grep = { disable = false },
                command_history = { disable = false },
            },
        },
    },
}
