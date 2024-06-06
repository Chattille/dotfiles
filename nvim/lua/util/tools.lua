local M = {}

---Find the root directory for the currrent path.
---@param files string|string[]|fun(name: string, path: string): boolean Names of the items to find.
---@param from string Path to begin searching from.
---@param type? string Type of items to be searched. Default 'file'.
---@return string # The first normalized path of all matching items.
function M.get_root(files, from, type)
    return vim.fs.find(files, {
        path = from,
        upward = true,
        stop = '~',
        type = type or 'file',
    })[1]
end

return M
