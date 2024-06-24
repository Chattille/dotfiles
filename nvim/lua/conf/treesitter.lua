-- }}} Directives {{{

local add_directive = vim.treesitter.query.add_directive

---`(#lua-match-clip! @capture "pattern")`
---Like `offset!` but the range is set in line with the matched text.
local function lua_match_clip(mat, _, bufnr, pred, meta)
    local id = pred[2]

    for _, node in ipairs(mat[id]) do
        local text = vim.treesitter.get_node_text(node, bufnr)
        local s, e = text:find(pred[3])

        if s and e then
            local sr, sc, er, _ = vim.treesitter.get_node_range(node)

            if not meta[id] then
                meta[id] = {}
            end
            meta[id].range = { sr, sc + s - 1, er, sc + e }
        end
    end
end

---(#conceal-pairs! @capture "text-1" "conceal-1" ...)
---Conceal text-n with conceal-n for the capture group if matched.
local function conceal_pairs(mat, _, bufnr, pred, meta)
    local id = pred[2]

    for _, node in ipairs(mat[id]) do
        local text = vim.treesitter.get_node_text(node, bufnr)

        for i = 3, #pred, 2 do
            local pattern = pred[i]
            local conceal = pred[i + 1]

            if pattern == text then
                if not meta[id] then
                    meta[id] = {}
                end
                meta[id].conceal = conceal
                break
            end
        end
    end
end

---(#devicon! @capture)
---Conceal with the corresponding web devicon icon based on its text.
local function devicon(mat, _, bufnr, pred, meta)
    local id = pred[2]
    local get_icon = require('nvim-web-devicons').get_icon_by_filetype

    for _, node in ipairs(mat[id]) do
        local lang = vim.treesitter.get_node_text(node, bufnr):lower()
        local ft = vim.filetype.match { filename = 'a.' .. lang } or lang
        local icon = get_icon(ft)

        if icon then
            if not meta[id] then
                meta[id] = {}
            end
            meta[id].conceal = icon
        end
    end
end

add_directive('lua-match-clip!', lua_match_clip, { all = true })
add_directive('conceal-pairs!', conceal_pairs, { all = true })
add_directive('devicon!', devicon, { all = true })
