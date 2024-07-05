local snippets = {
    s(
        'main',
        fmt(
            [[
            if __name__ == "__main__":
                {}
            ]],
            { i(0) }
        )
    ),
}

local autosnippets = {
    s(
        { trig = '^#!', trigEngine = 'pattern' },
        fmt(
            [[
            #!/usr/bin/env python3

            {}
            ]],
            { i(0) }
        )
    ),
}

return snippets, autosnippets
