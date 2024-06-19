local nonels = require 'null-ls'

nonels.setup {
    border = 'rounded',
    on_attach = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local mapped = vim.tbl_filter(function(keymap)
            return keymap.lhs == (vim.g.mapleader or '\\') .. 'jf'
        end, vim.api.nvim_buf_get_keymap(bufnr, 'n'))

        if vim.tbl_isempty(mapped) then -- keymap not set yet
            vim.keymap.set('n', '<Leader>jf', function()
                vim.lsp.buf.format { name = 'null-ls' }
            end, {
                desc = 'Format current buffer (none-ls)',
                buffer = bufnr,
            })
        end
    end,
    sources = {
        nonels.builtins.formatting.stylua.with {
            extra_args = {
                '--call-parentheses',
                'None',
                '--column-width',
                '79',
                '--indent-type',
                'Spaces',
                '--quote-style',
                'AutoPreferSingle',
                '--sort-requires',
            },
        },

        nonels.builtins.formatting.prettierd.with {
            filetypes = { 'javascript', 'typescript' },
            env = {
                PRETTIERD_DEFAULT_CONFIG = vim.fn.expand '~/.dotfiles/.prettierrc.json',
            },
        },
    },
}
