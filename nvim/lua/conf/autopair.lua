-- }}} Setup {{{

local npairs = require 'nvim-autopairs'
npairs.setup()

-- }}} Rules {{{

local Rule = require 'nvim-autopairs.rule'
local cond = require 'nvim-autopairs.conds'

-- [ custom rules ]

npairs.add_rules {
    -- | =<=> <|> =>=> <>|
    Rule('<', '>', { 'html', 'xml' }):with_move(cond.done()),
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
        :with_pair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.list_contains(unspaced, pair)
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        :with_del(function(opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local context = opts.line:sub(col - 1, col + 2)
            return vim.list_contains(spaced, context)
        end),
}

-- ( | ) =)=> (  )|
for _, pair in ipairs(cands) do
    npairs.add_rules {
        Rule(pair[1] .. ' ', ' ' .. pair[2])
            :with_pair(cond.none())
            :with_move(function(opts)
                return opts.char == pair[2]
            end)
            :with_del(cond.none())
            :use_key(pair[2]),
    }
end
