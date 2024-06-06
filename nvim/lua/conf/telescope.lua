local telescope = require 'telescope'

-- setup
telescope.setup {
    defaults = {
        mappings = {
            i = {
                ['<C-k>'] = 'move_selection_previous',
                ['<C-j>'] = 'move_selection_next',
                ['<C-p>'] = 'cycle_history_prev',
                ['<C-n>'] = 'cycle_history_next',
            },
        },
        preview = { msg_bg_fillchar = '·' },
        layout_strategy = 'flex',
        layout_config = {
            flex = {
                flip_columns = 90,
                flip_lines = 20,
            },
            horizontal = {
                preview_cutoff = 90,
                preview_width = 0.5,
            },
            vertical = {
                preview_cutoff = 20,
                preview_height = 0.4,
            },
        },
    },
}

-- telescope extensions
telescope.load_extension 'fzf'
