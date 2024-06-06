return {
    -- integrated terminal
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        opts = { open_mapping = '<C-t>', close_on_exit = false },
        cmd = {
            'TermSelect',
            'TermExec',
            'ToggleTerm',
            'ToggleTermSetName',
            'ToggleTermSendCurrentLine',
            'ToggleTermSendVisualLines',
            'ToggleTermSendVisualSelection',
            'ToggleTermToggleAll',
        },
        keys = { { '<C-t>', mode = { 'n', 'i' }, desc = 'Toggle terminal' } },
    },

    -- task manager
    {
        'stevearc/overseer.nvim',
        opts = {
            strategy = {
                'toggleterm',
                direction = 'horizontal',
            },
            task_list = {
                direction = 'left',
                min_width = 0.3,
                bindings = { ['<Space>'] = 'RunAction' },
            },
            templates = { 'runners' },
        },
        cmd = {
            'OverseerBuild',
            'OverseerClearCache',
            'OverseerClose',
            'OverseerDeleteBundle',
            'OverseerInfo',
            'OverseerLoadBundle',
            'OverseerOpen',
            'OverseerQuickAction',
            'OverseerRun',
            'OverseerRunCmd',
            'OverseerSaveBundle',
            'OverseerTaskAction',
            'OverseerToggle',
        },
        keys = {
            {
                '<Leader>r',
                function()
                    vim.cmd 'silent update'
                    require('overseer').run_template { tags = { 'DEFAULT' } }
                end,
                desc = 'Run default task',
            },
            {
                '<Leader>R',
                function()
                    vim.cmd 'silent update'
                    require('overseer').run_template()
                end,
                desc = 'Choose task and run',
            },
            {
                '<Leader>t',
                function()
                    require('overseer').toggle()
                end,
                desc = 'Toggle task list',
            },
        },
    },
}
