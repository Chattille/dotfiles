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
            component_aliases = {
                default = {
                    'on_exit_set_status',
                    'toggleterm',
                    {
                        'on_complete_dispose',
                        require_view = { 'SUCCESS', 'FAILURE' },
                    },
                },
            },
            form = { border = 'rounded' },
            task_list = {
                direction = 'left',
                min_width = 0.3,
                bindings = { ['<Space>'] = 'RunAction' },
            },
        },
        cmd = {
            'OverseerClose',
            'OverseerOpen',
            'OverseerRun',
            'OverseerShell',
            'OverseerTaskAction',
            'OverseerToggle',
        },
        keys = {
            {
                '<Leader>r',
                function()
                    vim.cmd 'silent update'
                    require('overseer').run_task { tags = { 'DEFAULT' } }
                end,
                desc = 'Run default task',
            },
            {
                '<Leader>R',
                function()
                    vim.cmd 'silent update'
                    require('overseer').run_task()
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
