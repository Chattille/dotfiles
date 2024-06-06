local M = {}

-- stylua: ignore
M.kinds = {
    Class         = '{',
    Color         = '#',
    Constant      = '=',
    Constructor   = '(',
    Enum          = '|',
    EnumMember    = ',',
    Event         = '!',
    Field         = '~',
    File          = '-',
    Folder        = '/',
    Function      = 'λ',
    Interface     = '%',
    Keyword       = '`',
    Method        = '.',
    Module        = '^',
    Operator      = '+',
    Property      = "'",
    Reference     = '@',
    Snippet       = '<',
    Struct        = '&',
    Text          = '*',
    TypeParameter = '>',
    Unit          = '"',
    Value         = '_',
    Variable      = '$',
}

-- stylua: ignore
M.symbols = {
    Array         = 'Ar',
    Boolean       = 'Bl',
    Class         = 'Cl',
    Component     = 'Cp',
    Constant      = 'Ct',
    Constructor   = 'Cr',
    Enum          = 'En',
    EnumMember    = 'Em',
    Event         = 'Ev',
    Field         = 'Fd',
    File          = 'Fl',
    Fragment      = 'Fm',
    Function      = 'Fn',
    Interface     = 'If',
    Key           = 'Ky',
    Macro         = 'Mc',
    Method        = 'Mt',
    Module        = 'Md',
    Namespace     = 'Ns',
    Null          = 'Nl',
    Number        = 'Nm',
    Object        = 'Ob',
    Operator      = 'Op',
    Package       = 'Pk',
    Parameter     = 'Pr',
    Property      = 'Pt',
    StaticMethod  = 'Sm',
    String        = 'Sg',
    Struct        = 'St',
    TypeAlias     = 'Ta',
    TypeParameter = 'Tp',
    Variable      = 'Vb',
}

-- stylua: ignore
M.diagnostics = {
    error   = '󰅙',
    warning = '',
    info    = '󰋗',
    hint    = '',
}

-- stylua: ignore
M.git = {
    unstaged  = '󰍷',
    staged    = '',
    unmerged  = '',
    renamed   = '󰬫',
    untracked = '',
    deleted   = '',
    ignored   = '',
}

-- stylua: ignore
M.diff = {
    added    = '',
    modified = '',
    removed  = '',
}

M.specials = {
    ['01-01'] = '🧨 🎊',
    ['02-14'] = '💘 🌹',
    ['03-08'] = '🌺 👗',
    ['04-01'] = '💩 💩',
    ['05-01'] = '🛠️ 💼',
    ['05-04'] = '🚩 🔥',
    ['06-01'] = '🍬 🍭',
    ['09-10'] = '🖊️ 📖',
    ['10-01'] = '🎉 🎺',
    ['10-31'] = '💀 🦇',
    ['12-24'] = '🔔 🌟',
    ['12-25'] = '🎁 🎄',
}

return M
