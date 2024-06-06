local map = vim.keymap.set

-- windows and buffers
map('n', ';', '<C-w>')
map('n', '<C-s>', '<Cmd>nohlsearch<CR>')
map('n', ';s', '<Cmd>silent update<CR>')
map('n', ';X', '<Cmd>quit!<CR>')
map('n', ';Q', '<Cmd>update | quit<CR>')
-- map('n', ';w', function()
--     vim.api.nvim_buf_delete(0, {})
-- end)

-- cmdline motion
map('c', '<C-a>', '<C-b>')
map('c', '<C-b>', '<Left>')
map('c', '<C-f>', '<Right>')
map('c', '<C-j>', '<S-Left>')
map('c', '<C-k>', '<S-Right>')

-- proper quit

---Filetypes ignored on quit
local autoclosables = {
    'NvimTree',
    'Outline',
    'OverseerList',
    'dap-repl',
    'dapui_console',
    'dapui_scopes',
    'dapui_stacks',
    'dapui_watches',
    'dapui_breakpoints',
    'toggleterm',
}

---Print out less verbose error messages.
---
---@param cmd string NeoVim command.
local function call(cmd)
    xpcall(vim.cmd, function(msg)
        local err = string.gsub(msg, '^.+Vim%(%w+%):', '')
        vim.notify(err, vim.log.levels.ERROR)
    end, 'silent ' .. cmd)
end

---Count non-autoclosable windows.
---
---@param wins number[] List of windows.
local function nonauto_count(wins)
    return #vim.tbl_filter(function(win)
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
        return not vim.tbl_contains(autoclosables, ft)
    end, wins)
end

---Quit NeoVim or tab on last non-autoclosable window.
local function quit()
    local wins = vim.api.nvim_tabpage_list_wins(0)
    if
        vim.tbl_contains(autoclosables, vim.bo.filetype)
        or nonauto_count(wins) >= 2
    then
        call 'quit'
        return
    end

    -- last non-autoclosable window
    for _, win in ipairs(wins) do -- close every window
        call('call win_execute(' .. win .. ', "quit")')
    end
end

map(
    'n',
    ';q',
    quit,
    { desc = 'Quit NeoVim or tab on last non-autoclosable window' }
)
