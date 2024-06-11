-- }}} UI {{{

local icons = require 'util.icons'
local sev = vim.diagnostic.severity

-- diagnostic icons
vim.diagnostic.config {
    severity_sort = true,
    signs = {
        text = {
            [sev.ERROR] = icons.diagnostics.error,
            [sev.WARN] = icons.diagnostics.warning,
            [sev.INFO] = icons.diagnostics.info,
            [sev.HINT] = icons.diagnostics.hint,
        },
    },
}

-- hover window
vim.lsp.handlers['textDocument/hover'] =
    vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })

-- :LspInfo window
require('lspconfig.ui.windows').default_options.border = 'rounded'

-- }}} Helpers {{{

local map = vim.keymap.set
local mappings = {
    codeAction = {
        lhs = 'ga',
        rhs = vim.lsp.buf.code_action,
        desc = 'Code actions',
    },
    definition = {
        lhs = '<Leader>jd',
        rhs = function()
            require('telescope.builtin').lsp_definitions()
        end,
        desc = 'Go to definition',
    },
    diagnostic = {
        lhs = '<Leader>jD',
        rhs = function()
            require('trouble').toggle { mode = 'diagnostics' }
        end,
        desc = 'Toggle diagnostic window',
    },
    documentSymbol = {
        lhs = '<Leader>jo',
        rhs = function()
            local bufnr = vim.api.nvim_get_current_buf()
            local builtin = require 'telescope.builtin'
            local remap = function(fb, type)
                map('n', '<Leader>jo', fb, {
                    desc = 'List document symbols (' .. type .. ')',
                    buffer = bufnr,
                })
            end
            -- prioritize treesitter over LSPs
            if vim.treesitter.highlighter.active[bufnr] then
                builtin.treesitter()
                remap(builtin.treesitter, 'treesitter')
            else
                builtin.lsp_document_symbols()
                remap(builtin.lsp_document_symbols, 'LSP')
            end
        end,
        desc = 'List document symbols',
    },
    formatting = {
        lhs = '<Leader>jf',
        rhs = vim.lsp.buf.format,
        desc = 'Format current buffer',
    },
    hover = {
        lhs = '<Leader>jk',
        rhs = vim.lsp.buf.hover,
        desc = 'Display hover information',
    },
    references = {
        lhs = '<Leader>jR',
        rhs = function()
            require('telescope.builtin').lsp_references()
        end,
        desc = 'Show references',
    },
    rename = {
        lhs = '<Leader>jr',
        rhs = vim.lsp.buf.rename,
        desc = 'Rename references',
    },
}

local function set_keymaps(bufnr)
    for _, opt in pairs(mappings) do
        map('n', opt.lhs, opt.rhs, { desc = opt.desc, buffer = bufnr })
    end
end

local function default_on_attach(_, bufnr)
    set_keymaps(bufnr)
end

-- }}} LSPs {{{

local lspconfig = require 'lspconfig'
local root_pattern = lspconfig.util.root_pattern
local servers = {
    'ccls',
    'cssls',
    'html',
    'jsonls',
    'lua_ls',
    'tsserver',
}

local enhanced_opts = {
    ['ccls'] = function(opts)
        opts.root_dir = root_pattern(
            '.clang-format',
            '.git',
            'compile_commands.json',
            '.ccls'
        )
        opts.init_options = { cache = { directory = '/tmp/.ccls-cache' } }
    end,
    ['lua_ls'] = function(opts)
        -- disable default formatter; prefering stylua
        opts.settings = { Lua = { format = { enable = false } } }
    end,
}

local defcap = require('cmp_nvim_lsp').default_capabilities()
defcap.textDocument.completion.completionItem.snippetSupport = true

for _, server in ipairs(servers) do
    local opts = {
        on_attach = default_on_attach,
        capabilities = defcap,
    }

    if enhanced_opts[server] then
        enhanced_opts[server](opts)
    end

    lspconfig[server].setup(opts)
end
