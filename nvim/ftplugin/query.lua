local helpers = require 'util.helpers'
helpers.configure_diagnostics()

local keymap = helpers.get_diagnostic_keymap()
vim.keymap.set('n', keymap.lhs, keymap.rhs, { desc = keymap.desc })
