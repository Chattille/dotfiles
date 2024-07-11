return {
    -- autopair
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require 'conf.autopair'
        end,
    },

    -- surround
    {
        'kylechui/nvim-surround',
        version = '*',
        opts = {
            move_cursor = false,
            keymaps = {
                -- lowercase: on same line; uppercase: on new lines
                -- a/d/r: for text objects; l: for current line
                normal = ',a',
                normal_cur = ',l',
                normal_line = ',A',
                normal_cur_line = ',L',
                visual = ',a',
                visual_line = ',A',
                delete = ',d',
                change = ',r',
                change_line = ',R',
            },
        },
        keys = {
            { ',a', mode = { 'n', 'x' }, desc = 'Add pairs' },
            { ',l', desc = 'Add pairs for current line' },
            { ',A', mode = { 'n', 'x' }, desc = 'Add pairs on new lines' },
            { ',L', desc = 'Add pairs for current line on new lines' },
            { ',d', desc = 'Delete pairs' },
            { ',r', desc = 'Replace pairs' },
            { ',R', desc = 'Replace pairs on new lines' },
        },
    },

    -- commenter
    {
        'numToStr/Comment.nvim',
        config = true,
        keys = {
            { 'gcc', desc = 'Toggle line-wise comment' },
            { 'gcO', desc = 'Add line-wise comment on the current line' },
            { 'gco', desc = 'Add line-wise comment on the next line' },
            { 'gcA', desc = 'Add line-wise comment at the end of line' },
            { 'gc', mode = { 'o', 'x' }, desc = 'Toggle line-wise comment' },
            { 'gbc', desc = 'Toggel block-wise comment' },
            { 'gb', mode = { 'o', 'x' }, desc = 'Toggle block-wise comment' },
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
