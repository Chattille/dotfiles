local snippets = {
    s('vp', fmt([[vim.print({})]], { i(1) })),
    s(
        'new',
        fmt(
            [[
            function {1}.new()
                return setmetatable({}, {{ __index = {1} }})
            end
            ]],
            { i(1), i(2, '{}') },
            { repeat_duplicates = true }
        )
    ),
}

return snippets
