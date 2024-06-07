local map = vim.keymap.set
local bufferline = require 'bufferline'

bufferline.setup {
    options = {
        mode = 'buffers',
        indicator = { style = 'none' },
        offsets = {
            { filetype = 'NvimTree', text = 'File Explorer' },
        },
        separator_style = 'slant',
        always_show_bufferline = false,
    },
    highlights = {
        tab = { fg = '#45475a' },
        tab_selected = { fg = '#6c7086' },
    },
}

map('n', '[b', function()
    bufferline.cycle(-1)
end, { desc = 'Cycle to previous buffer' })
map('n', ']b', function()
    bufferline.cycle(1)
end, { desc = 'Cycle to next buffer' })
map('n', ';b', function()
    bufferline.pick()
end, { desc = 'Jump to buffer' })
map('n', '<b', function()
    bufferline.move(-1)
end, { desc = 'Move current buffer to left' })
map('n', '>b', function()
    bufferline.move(1)
end, { desc = 'Move current buffer to right' })
