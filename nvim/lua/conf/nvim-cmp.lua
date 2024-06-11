local cmp = require 'cmp'
local luasnip = require 'luasnip'
local kinds = require('util.icons').kinds

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = { documentation = cmp.config.window.bordered() },
    formatting = {
        format = function(_, vim_item)
            vim_item.kind =
                string.format('%s %s', kinds[vim_item.kind], vim_item.kind)
            return vim_item
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping {
            i = cmp.mapping.scroll_docs(-3),
            c = cmp.mapping.scroll_docs(-2),
        },
        ['<C-f>'] = cmp.mapping {
            i = cmp.mapping.scroll_docs(3),
            c = cmp.mapping.scroll_docs(2),
        },
        ['<C-e>'] = cmp.mapping(cmp.mapping.close(), { 'i', 'c' }),
        ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i' }),
        ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i' }),
        ['<Tab>'] = cmp.mapping {
            i = function(fallback)
                if luasnip.expandable() then
                    luasnip.expand()
                elseif cmp.visible() then
                    cmp.confirm { select = true }
                elseif luasnip.locally_jumpable(1) then
                    luasnip.jump(1)
                else
                    fallback()
                end
            end,
            s = function(fallback)
                if luasnip.locally_jumpable(1) then
                    luasnip.jump(1)
                else
                    fallback()
                end
            end,
            c = cmp.mapping.select_next_item(),
        },
        ['<S-Tab>'] = cmp.mapping {
            i = function(fallback)
                if luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end,
            s = function(fallback)
                if luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end,
            c = cmp.mapping.select_prev_item(),
        },
    },
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            require('cmp-under-comparator').under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    sources = cmp.config.sources({
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'path' },
    }, {
        { name = 'buffer' },
    }),
}

cmp.setup.cmdline({ '/', '?' }, {
    sources = { { name = 'buffer' } },
})

cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' },
    }, {
        { name = 'cmdline' },
    }),
})
