-- load snippets
local snip_path = vim.fn.stdpath 'config' .. '/lua/snip'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_lua').lazy_load { paths = snip_path }

-- setup
luasnip.setup { enable_autosnippets = true }

-- extend snippets
luasnip.filetype_extend('typescript', { 'javascript' })

-- edit snippets
vim.api.nvim_create_user_command('LuaSnipEdit', function(opts)
    require('luasnip.loaders').edit_snippet_files {
        ft_filter = function(ft)
            return ft ~= 'all'
        end,
        extend = function(ft, paths)
            if #paths == 0 then
                local ftype = #opts.args == 0 and ft or opts.args
                return {
                    {
                        ftype .. '.lua',
                        snip_path .. '/' .. ftype .. '.lua',
                    },
                }
            end

            return {}
        end,
    }
end, { complete = 'filetype', nargs = '?', desc = 'Edit snippets' })
