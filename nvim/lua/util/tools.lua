local M = {}

---Find the root directory for the currrent path.
---
---@param files string|string[]|fun(name: string, path: string): boolean Names of the items to find.
---@param from string Path to begin searching from.
---@param type? string Type of items to be searched. Default 'file'.
---@param last? boolean Return the last (`true`) or first (`false`) path.
---@return string|nil # Base directory of the last/first item.
function M.get_root(files, from, type, last)
    local paths = vim.fs.find(files, {
        path = from,
        upward = true,
        stop = '~',
        type = type or 'file',
        limit = last and math.huge or 1,
    })
    return vim.fs.dirname(paths[last and #paths or 1])
end

---Get base directory for the current buffer.
---
---@return string # Absolute directory path.
function M.get_current_dir()
    local bufname = vim.api.nvim_buf_get_name(0)
    local realpath = vim.uv.fs_realpath(bufname)
    local cwd

    if bufname == '' then -- [No Name]
        cwd = vim.uv.cwd()
    elseif not realpath then -- new file
        cwd = vim.fs.dirname(bufname)
    else
        cwd = vim.fs.dirname(realpath) -- currrent file or symlink
    end

    return cwd
end

return M
