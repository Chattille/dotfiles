vim.wo.conceallevel = 2

-- override default styles of task lists
vim.api.nvim_set_hl(0, '@markup.list.checked', { fg = '#7f849c' })
vim.api.nvim_set_hl(0, '@markup.list.unchecked', { fg = '#a6e3a1' })
