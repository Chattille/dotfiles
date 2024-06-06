-- }}} Preparation {{{

local icons = require 'util.icons'
local palette =
    require('catppuccin.palettes').get_palette(require('catppuccin').flavour)

local mode_colors = {
    n = palette.blue,
    i = palette.yellow,
    v = palette.green,
    V = palette.green,
    [''] = palette.green,
    c = palette.rosewater,
    no = palette.blue,
    s = palette.pink,
    S = palette.pink,
    [''] = palette.pink,
    ic = palette.yellow,
    R = palette.teal,
    Rv = palette.teal,
    cv = palette.blue,
    r = palette.lavender,
    rm = palette.lavender,
    ['r?'] = palette.lavender,
    ['!'] = palette.blue,
    t = palette.blue,
}

local conditions = {
    show_in_thin = function()
        return vim.fn.winwidth(0) > 40
    end,
    show_in_wide = function()
        return vim.fn.winwidth(0) > 80
    end,
    show_in_extra_wide = function()
        return vim.fn.winwidth(0) > 120
    end,
}

local mode_indicator = {
    function()
        return '█'
    end,
    color = function()
        return { fg = mode_colors[vim.fn.mode()] }
    end,
    padding = 0,
}

-- }}} Setup {{{

local lualine = require 'lualine'

lualine.setup {
    options = {
        component_separators = '',
        section_separators = '',
        refresh = { statusline = 500 },
    },
    sections = {
        lualine_c = {
            mode_indicator,

            { 'filename' },

            {
                'branch',
                icon = '',
                color = { fg = palette.peach },
                cond = conditions.show_in_extra_wide,
            },

            {
                'diff',
                symbols = {
                    added = icons.diff.added .. ' ',
                    modified = icons.diff.modified .. ' ',
                    removed = icons.diff.removed .. ' ',
                },
                cond = conditions.show_in_wide,
            },
        },
        lualine_x = {
            {
                'diagnostics',
                sources = { 'nvim_lsp' },
                sections = { 'error', 'warn', 'hint' },
                symbols = {
                    error = icons.diagnostics.error .. ' ',
                    warn = icons.diagnostics.warning .. ' ',
                    hint = icons.diagnostics.hint .. ' ',
                },
                cond = conditions.show_in_wide,
            },

            { -- LSP servers
                function()
                    local clients = vim.lsp.get_clients {
                        bufnr = vim.api.nvim_get_current_buf(),
                    }
                    if next(clients) == nil then
                        return ''
                    end

                    local names = {}
                    for _, client in ipairs(clients) do
                        table.insert(names, client.name:upper())
                    end

                    return table.concat(names, '  ')
                end,
                icon = '',
                color = { fg = palette.sapphire },
                cond = conditions.show_in_extra_wide,
            },

            { 'location', cond = conditions.show_in_thin },

            { -- special dates
                function()
                    return icons.specials[os.date '%m-%d'] or ''
                end,
                padding = { right = 1 },
            },

            mode_indicator,
        },
        -- unused; disable defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
    },
    inactive_sections = {
        lualine_c = { { 'filename', padding = 0 } },
        -- unused; disable defaults
        lualine_a = {},
        lualine_b = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    extensions = {
        'nvim-tree',
        'overseer',
        'symbols-outline',
        'toggleterm',
    },
}

-- disable tabline and winbar
lualine.hide { place = { 'tabline', 'winbar' }, unhide = false }
