local map = vim.keymap.set
local del = vim.keymap.del
local api = require 'nvim-tree.api'
local git_icons = require('util.icons').git

vim.api.nvim_set_hl(0, 'NvimTreeOpenedHL', { fg = '#f5c2e7', underline = true })

require('nvim-tree').setup {
    on_attach = function(bufnr)
        api.config.mappings.default_on_attach(bufnr)

        del('n', 'o', { buffer = bufnr })
        del('n', '<CR>', { buffer = bufnr })

        map(
            'n',
            '<Space>',
            api.node.open.edit,
            { buffer = bufnr, desc = 'nvim-tree: Open' }
        )
    end,
    view = {
        width = 25,
        signcolumn = 'no',
    },
    renderer = {
        add_trailing = true,
        group_empty = true,
        special_files = {
            'Cargo.toml',
            'Makefile',
            'README.md',
            'readme.md',
        },
        highlight_opened_files = 'name',
        indent_markers = { enable = true },
        icons = {
            glyphs = {
                git = git_icons,
            },
        },
    },
    actions = {
        file_popup = {
            open_win_config = { border = 'rounded' },
        },
    },
    update_focused_file = { enable = true },
}

map('n', '<C-k>', function()
    api.tree.toggle { find_file = true }
end, { desc = 'Toggle NvimTree' })
