local nonels = require 'null-ls'

nonels.setup {
    border = 'rounded',
    sources = {
        nonels.builtins.formatting.stylua.with {
            extra_args = {
                '--call-parentheses',
                'None',
                '--column-width',
                '79',
                '--indent-type',
                'Spaces',
                '--quote-style',
                'AutoPreferSingle',
                '--sort-requires',
            },
        },
    },
}
