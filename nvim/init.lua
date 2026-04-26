-- providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.python3_host_prog = vim.fn.expand '~/.local/share/nvim/.venv/bin/python'
vim.g.node_host_prog =
    vim.fn.expand '~/.local/share/nvim/node_modules/.bin/neovim-node-host'

-- options
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.bo.modeline = true
vim.wo.number = true
vim.wo.signcolumn = 'yes:1'
vim.go.keywordprg = ':help'
vim.go.mouse = ''
vim.go.showmode = false

-- plugins
require 'conf'
