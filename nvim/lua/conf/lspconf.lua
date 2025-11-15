-- }}} UI {{{

-- diagnostics ui
local helpers = require 'util.helpers'
helpers.configure_diagnostics()

-- }}} Initialization {{{

local disable_defaults =
    vim.api.nvim_create_augroup('DisableLspDefaults', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local kmap = vim.fn.maparg('K', 'n')
        if kmap ~= '' then
            vim.keymap.del('n', 'K', { buffer = ev.buf })
        end
    end,
    group = disable_defaults,
})

-- }}} Helpers {{{

local load_json_file = require('util.files').load_json_file
local map = vim.keymap.set

local mappings = {
    codeAction = {
        lhs = 'ga',
        rhs = vim.lsp.buf.code_action,
        desc = 'Code actions',
    },
    codeLens = {
        lhs = 'gl',
        rhs = vim.lsp.codelens.run,
        desc = 'Run codelens in the current line',
    },
    definition = {
        lhs = '<Leader>jd',
        rhs = function()
            require('telescope.builtin').lsp_definitions()
        end,
        desc = 'Go to definition',
    },
    diagnostic = helpers.get_diagnostic_keymap(),
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
    documentFormatting = {
        lhs = '<Leader>jf',
        rhs = vim.lsp.buf.format,
        desc = 'Format current buffer',
    },
    hover = {
        lhs = '<Leader>jk',
        rhs = function()
            vim.lsp.buf.hover { border = 'rounded' }
        end,
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

---@class KeymapOpts
---@field client unknown LSP cilent.
---@field bufnr number Buffer number.
---@field skip? string[] List of providers that should keymaps not be set for.

---Set keymaps.
---@param opts KeymapOpts
local function set_keymaps(opts)
    local caps = opts.client.server_capabilities

    for provider, opt in pairs(mappings) do
        if
            provider == 'diagnostic'
            or (
                caps[provider .. 'Provider']
                and not (opts.skip and vim.list_contains(opts.skip, provider))
            )
        then
            map(
                'n',
                opt.lhs,
                opt.rhs,
                { desc = opt.desc, buffer = opts.bufnr }
            )
        end
    end
end

---Default on_attach() for all LSPs.
local function default_on_attach(client, bufnr)
    set_keymaps { client = client, bufnr = bufnr }
end

---Same as the default on_attach() but with formatter disabled.
local function no_formatter_on_attach(client, bufnr)
    set_keymaps {
        client = client,
        bufnr = bufnr,
        skip = { 'documentFormatting' },
    }
end

---Is currently in a Vue project?
---@return boolean
local function is_in_vue()
    local root = vim.fs.root(0, 'package.json')
    if root then
        local json = load_json_file(root .. '/package.json')
        if json.dependencies and json.dependencies.vue then
            return true
        end
    end
    return false
end

-- }}} LSPs {{{

local lspconfig = require 'lspconfig'
local root_pattern = lspconfig.util.root_pattern
local servers = {
    'ccls',
    'cssls',
    'emmet_language_server',
    'html',
    'jsonls',
    'lua_ls',
    'pyright',
    'ts_ls',
    'vue_ls',
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
    ['emmet_language_server'] = function(opts)
        opts.init_options = {
            showSuggestionsAsSnippets = true,
            syntaxProfiles = { html = 'xhtml' },
        }
    end,
    ['lua_ls'] = function(opts)
        -- disable default formatter; preferring stylua
        opts.settings = { Lua = { format = { enable = false } } }
        opts.on_attach = no_formatter_on_attach
    end,
    ['ts_ls'] = function(opts)
        -- disable default formatter; preferring prettierd
        opts.on_attach = no_formatter_on_attach

        if is_in_vue() then -- add support for Vue projects
            opts.init_options = {
                plugins = {
                    {
                        name = '@vue/typescript-plugin',
                        location = '',
                        languages = { 'javascript', 'typescript', 'vue' },
                    },
                },
            }
            opts.filetypes = { 'javascript', 'typescript', 'vue' }
        end
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

    vim.lsp.config(server, opts)
    vim.lsp.enable(server)
end
