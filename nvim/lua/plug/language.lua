return {
    {
        'olrtg/nvim-emmet',
        config = function()
            vim.keymap.set({ 'n', 'x' }, ',e', function()
                require('nvim-emmet').wrap_with_abbreviation()
            end, { desc = 'Wrap with abbreviation' })
        end,
        ft = { 'css', 'html', 'less', 'scss' },
    },

    {
        'yochem/jq-playground.nvim',
        opts = {
            output_window = {
                width = 0.6,
                name = 'JQ Output',
            },
            query_window = {
                height = 0.2,
                scratch = true,
                name = 'JQ Query Editor',
            },
        },
        ft = { 'json', 'jsonc' },
        cmd = { 'JqPlayground' },
    },
}
