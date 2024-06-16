return {
    -- completion engine
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            {
                { 'L3MON4D3/LuaSnip' },
                -- completion sources
                { 'saadparwaiz1/cmp_luasnip' },
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'hrsh7th/cmp-nvim-lsp-signature-help' },
                { 'hrsh7th/cmp-path' },
                { 'hrsh7th/cmp-buffer' },
                { 'hrsh7th/cmp-cmdline' },
                { 'lukas-reineke/cmp-under-comparator' },
            },
        },
        event = { 'InsertEnter', 'CmdlineEnter' },
        config = function()
            require 'conf.nvim-cmp'
        end,
    },

    -- snippet engine
    {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        config = function()
            require 'conf.snippet'
        end,
    },
}
