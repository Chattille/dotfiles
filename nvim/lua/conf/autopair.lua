-- }}} Setup {{{

local npairs = require 'nvim-autopairs'
npairs.setup()

-- }}} Rules {{{

local Rule = require 'nvim-autopairs.rule'
local cond = require 'nvim-autopairs.conds'

-- [ helpers ]

---Is the current character escaped?
---@param context any
---@return boolean
local function escaped(context)
    local prevall = context.line:sub(0, context.col - 1)
    local escseq = prevall:match [[(\\*)$]]

    if escseq and #escseq % 2 == 1 then
        return true
    else
        return false
    end
end

---Is the cursor in a TS capture?
---@param targets string[] List of capture names.
---@return boolean
local function ts_captured_by(targets)
    local captures = vim.treesitter.get_captures_at_cursor()
    local captured = false

    for _, capture in ipairs(captures) do
        if vim.tbl_contains(targets, capture) then
            captured = true
            break
        end
    end

    return captured
end

-- [ custom rules ]

local dollar_captures = { 'markup.raw', 'markup.raw.block' }

npairs.add_rules {
    -- | =<=> <|> =>=> <>|
    Rule('<', '>', { 'html', 'xml', 'ps1xml' }):with_move(cond.done()),

    -- | =$=> $|$    =$=> $$|$$
    --        $\pi|$ =$=> $\pi$|
    Rule('$', '$', 'markdown')
        :with_pair(function(context)
            return not ts_captured_by(dollar_captures) and not escaped(context)
        end)
        :with_move(function(context)
            local pair = context.line:sub(context.col - 1, context.col)
            return pair ~= '$$' and not escaped(context)
        end)
        :with_cr(cond.none())
        :use_undo(true),

    -- $$|$$ =<CR>=> $$
    --               |
    --               $$
    Rule('$$', '$$', 'markdown'):only_cr(),
}

-- [ spaced operators ]

local cands = {
    { '(', ')' },
    { '[', ']' },
    { '{', '}' },
}
local unspaced = {}
local spaced = {}

for _, pair in ipairs(cands) do
    table.insert(unspaced, pair[1] .. pair[2])
    table.insert(spaced, pair[1] .. '  ' .. pair[2])
end

-- (|) = => ( | )
npairs.add_rules {
    Rule(' ', ' ', '-markdown')
        :with_pair(function(context)
            local pair = context.line:sub(context.col - 1, context.col)
            return vim.list_contains(unspaced, pair)
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        :with_del(function(context)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local circum = context.line:sub(col - 1, col + 2)
            return vim.list_contains(spaced, circum)
        end),
}

-- ( | ) =)=> (  )|
for _, pair in ipairs(cands) do
    npairs.add_rules {
        Rule(pair[1] .. ' ', ' ' .. pair[2])
            :with_pair(cond.none())
            :with_move(function(context)
                return context.char == pair[2]
            end)
            :with_del(cond.none())
            :use_key(pair[2]),
    }
end

-- [ overriding ]

-- enable backticks conditionally
local backtick = npairs.get_rule '`'
npairs.remove_rule '`'
backtick.filetypes = { 'html', 'javascript', 'typescript', 'markdown', 'vue' }
npairs.add_rule(backtick)
