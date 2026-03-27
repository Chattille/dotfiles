local snippets = {
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
