return {
    -- autopair
    {
        'Chattille/pairs.nvim',
        event = { 'CmdlineEnter', 'InsertEnter' },
        config = function()
            require 'conf.pairs'
        end,
    },

    -- surround
    {
        'kylechui/nvim-surround',
        version = '*',
        init = function()
            vim.g.nvim_surround_no_mappings = true
        end,
        opts = { move_cursor = false },
        keys = {
            -- lowercase: on same line; uppercase: on new lines
            -- a/d/r: for text objects; l: for current line
            {
                ',a',
                '<Plug>(nvim-surround-normal)',
                desc = 'Add pairs',
            },
            {
                ',a',
                '<Plug>(nvim-surround-visual)',
                mode = 'x',
                desc = 'Add pairs (visual)',
            },
            {
                ',l',
                '<Plug>(nvim-surround-normal-cur)',
                desc = 'Add pairs for current line',
            },
            {
                ',A',
                '<Plug>(nvim-surround-normal-line)',
                desc = 'Add pairs on new lines',
            },
            {
                ',A',
                '<Plug>(nvim-surround-visual-line)',
                mode = 'x',
                desc = 'Add pairs on new lines (visual)',
            },
            {
                ',L',
                '<Plug>(nvim-surround-normal-cur-line)',
                desc = 'Add pairs for current line on new lines',
            },
            { ',d', '<Plug>(nvim-surround-delete)', desc = 'Delete pairs' },
            { ',r', '<Plug>(nvim-surround-change)', desc = 'Replace pairs' },
            {
                ',R',
                '<Plug>(nvim-surround-change-line)',
                desc = 'Replace pairs on new lines',
            },
        },
    },

    -- file explorer
    {
        'nvim-tree/nvim-tree.lua',
        config = function()
            require 'conf.explorer'
        end,
        keys = { { '<C-k>', desc = 'Toggle NvimTree' } },
    },

    -- motion
    {
        'folke/flash.nvim',
        opts = { modes = { char = { enabled = true } } },
        keys = {
            { 'f', mode = { 'n', 'o', 'x' }, desc = 'Enhanced f' },
            { 'F', mode = { 'n', 'o', 'x' }, desc = 'Enhanced F' },
            { 't', mode = { 'n', 'o', 'x' }, desc = 'Enhanced t' },
            { 'T', mode = { 'n', 'o', 'x' }, desc = 'Enhanced T' },
            {
                's',
                function()
                    require('flash').jump()
                end,
                mode = { 'n', 'o', 'x' },
                desc = 'Flash jump',
            },
            {
                '<C-s>',
                function()
                    require('flash').toggle()
                end,
                mode = 'c',
                desc = 'Toggle flash label on regular search',
            },
        },
    },

    -- buffer management
    {
        'famiu/bufdelete.nvim',
        cmd = { 'Bdelete', 'Bwipeout' },
        keys = {
            {
                ';w',
                function()
                    require('bufdelete').bufdelete()
                end,
                desc = 'Delete buffer without messing up window layout',
            },
        },
    },
}
