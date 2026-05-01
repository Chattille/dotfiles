local snippets = {
    s('log', fmt([[console.log({});]], { i(1) })),
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
        '!v',
        fmt(
            [[
            <script setup lang="ts">
            {}
            </script>

            <template>
            </template>

            <style scoped>
            </style>
            ]],
            { i(0) }
        )
    ),
}

return snippets
