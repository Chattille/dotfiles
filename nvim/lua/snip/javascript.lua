local snippets = {
    s('log', fmt([[console.log({});]], { i(1) })),
    s(
        'fn',
        fmt(
            [[
            function {}({}) {{
                {}
            }}
            ]],
            { i(1), i(2), i(3) }
        )
    ),
    s(
        'cls',
        fmt(
            [[
            class {} {{
                {}
            }}
            ]],
            { i(1), i(2) }
        )
    ),
}

return snippets
