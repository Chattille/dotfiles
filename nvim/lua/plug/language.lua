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
}
