local api = require 'nvim-tree.api'
local git_icons = require('util.icons').git

vim.api.nvim_set_hl(
    0,
    'NvimTreeOpenedHL',
    { fg = '#f5c2e7', underline = true }
)

require('nvim-tree').setup {
    on_attach = function(bufnr)
        local function bufmap(lhs, rhs, desc)
            vim.keymap.set(
                'n',
                lhs,
                rhs,
                { buffer = bufnr, desc = 'nvim-tree: ' .. desc }
            )
        end
        local function bufdel(lhs)
            vim.keymap.del('n', lhs, { buffer = bufnr })
        end

        api.config.mappings.default_on_attach(bufnr)

        bufdel 'o'
        bufdel '<CR>'
        bufdel ']c'
        bufdel '[c'
        bufdel 'd'
        bufdel 'D'

        bufmap('<Space>', api.node.open.edit, 'Open')
        bufmap(']g', api.node.navigate.git.next, 'Next Git')
        bufmap('[g', api.node.navigate.git.prev, 'Prev Git')
        bufmap('d', api.fs.trash, 'Trash')
        bufmap('D', api.fs.remove, 'Delete')
    end,
    view = {
        width = 25,
        signcolumn = 'no',
    },
    renderer = {
        add_trailing = true,
        group_empty = true,
        highlight_git = 'icon',
        special_files = {
            'Cargo.toml',
            'CMakeLists.txt',
            'LICENCE',
            'LICENSE',
            'Makefile',
            'package.json',
            'package-lock.json',
            'README.md',
            'readme.md',
        },
        highlight_opened_files = 'name',
        indent_markers = { enable = true },
        icons = {
            glyphs = { git = git_icons },
        },
    },
    trash = { cmd = 'trash' },
    actions = {
        file_popup = {
            open_win_config = { border = 'rounded' },
        },
    },
    update_focused_file = { enable = true },
}

vim.keymap.set('n', '<C-k>', function()
    api.tree.toggle { find_file = true }
end, { desc = 'Toggle NvimTree' })
