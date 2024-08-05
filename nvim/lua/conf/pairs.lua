local pairs = require 'pairs'

pairs.setup {
    mapping = { cu = true, cw = true, space = true },
}

pairs.add {
    {
        opener = '*',
        closer = '*',
        filetype = 'help',
        cr = false,
    },
    {
        opener = '|',
        closer = '|',
        filetype = 'help',
        cr = false,
    },
    {
        opener = '`',
        closer = '`',
        filetype = 'help',
        cr = false,
    },
}
