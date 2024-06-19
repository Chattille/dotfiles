local snippets = {
    s(
        'fn',
        fmt(
            [[
            function {}({}){} {{
                {}
            }}
            ]],
            { i(1), i(2), i(3), i(4) }
        )
    ),
    s(
        'efn',
        fmt(
            [[
            export function {}({}){} {{
                {}
            }}
            ]],
            { i(1), i(2), i(3), i(4) }
        )
    ),
}

return snippets
