local M = {}

---Set icons for diagnostic symbols.
function M.set_diagnostic_icons()
    local icons = require('util.icons').diagnostics
    local severity = vim.diagnostic.severity

    vim.diagnostic.config {
        severity_sort = true,
        signs = {
            text = {
                [severity.ERROR] = icons.error,
                [severity.WARN] = icons.warning,
                [severity.INFO] = icons.info,
                [severity.HINT] = icons.hint,
            },
        },
    }
end

---Get the keymap for toggling the diagnostic window.
function M.get_diagnostic_keymap()
    return {
        lhs = '<Leader>jD',
        rhs = function()
            require('trouble').toggle { mode = 'diagnostics' }
        end,
        desc = 'Toggle diagnostic window',
    }
end

return M
