-- providers
vim.g.loaded_perl_provider = 0
vim.g.python3_host_prog = '/root/.pyenv/shims/python'
vim.g.node_host_prog =
    vim.fn.glob '/root/.nvm/versions/node/v*/lib/node_modules/neovim/bin/cli.js'

-- options
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.bo.modeline = true
vim.bo.keywordprg = ':help'
vim.wo.number = true
vim.wo.signcolumn = 'yes:1'
vim.go.mouse = ''
vim.go.showmode = false

-- plugins
require 'conf'
