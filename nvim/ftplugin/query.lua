local helpers = require 'util.helpers'
helpers.set_diagnostic_icons()

local keymap = helpers.get_diagnostic_keymap()
vim.keymap.set('n', keymap.lhs, keymap.rhs, { desc = keymap.desc })
