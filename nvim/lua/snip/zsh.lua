local snippets = {}

local autosnippets = {
    s(
        { trig = '^#!', trigEngine = 'pattern' },
        fmt(
            [[
            #!/usr/bin/env zsh

            {}
            ]],
            { i(0) }
        )
    ),
}

return snippets, autosnippets
