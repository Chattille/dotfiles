local M = {}

---Get real base directory for the current buffer.
---
---@return string # Real absolute directory path.
function M.buf_get_real_base()
    local bufname = vim.api.nvim_buf_get_name(0)
    local realpath = vim.uv.fs_realpath(bufname)
    local cwd

    if bufname == '' then -- [No Name]
        cwd = vim.uv.cwd() or vim.fn.getcwd()
    elseif not realpath then -- new file
        cwd = vim.fs.dirname(bufname)
    else
        cwd = vim.fs.dirname(realpath) -- currrent file or symlink
    end

    return cwd
end

return M
