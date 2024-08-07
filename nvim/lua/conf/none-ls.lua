local nonels = require 'null-ls'
local masonpath = vim.fn.expand '~/.local/share/nvim/mason'

---Launch blackd in the background.
local function launch_blackd()
    local id = vim.fn.jobstart(masonpath .. '/packages/black/venv/bin/blackd')
    if id == 0 then
        vim.notify('invalid arguments', vim.log.levels.ERROR)
    end
    if id == -1 then
        vim.notify('blackd not executable', vim.log.levels.ERROR)
    end
end

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

        -- pre-tasks
        if vim.bo.filetype == 'python' then
            launch_blackd()
        end
    end,
    sources = {
        -- lua
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

        -- js/ts
        nonels.builtins.formatting.prettierd.with {
            filetypes = { 'javascript', 'typescript' },
            env = {
                PRETTIERD_DEFAULT_CONFIG = vim.fn.expand '~/.dotfiles/.prettierrc.json',
            },
        },

        -- python
        nonels.builtins.formatting.isort,
        nonels.builtins.formatting.blackd.with {
            config = { line_length = 79 },
        },
    },
}
