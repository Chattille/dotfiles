local tool = require 'util.tools'
local enabled_fts = { 'c', 'cpp' }
local tglt_default = { 'toggleterm', direction = 'horizontal' }

---Get the top root directory for CMake projects.
---
---@return string|nil # Root path.
local function get_cmake_root()
    return tool.get_root(
        'CMakeLists.txt',
        tool.get_current_dir(),
        'file',
        true
    )
end

return {
    condition = {
        callback = function(opts)
            return vim.tbl_contains(
                enabled_fts,
                opts.filetype or vim.bo.filetype
            ) and (get_cmake_root() and true or false)
        end,
    },
    generator = function(_, callback)
        local root = get_cmake_root()
        if not root then
            vim.notify('Root directory not found.', vim.log.levels.ERROR)
            return
        end
        local build = root .. '/build'

        callback {
            {
                name = '@build & run',
                tags = { 'BUILD', 'RUN', 'DEFAULT' },
                builder = function()
                    return {
                        name = 'Build and Run',
                        strategy = {
                            'orchestrator',
                            tasks = {
                                {
                                    'build (cmake & make)',
                                    strategy = 'jobstart',
                                },
                                'run',
                            },
                        },
                    }
                end,
            },
            {
                name = 'build (cmake & make)',
                tags = { 'BUILD' },
                params = {
                    strategy = {
                        type = 'string',
                        optional = true,
                        default = tglt_default,
                    },
                },
                builder = function(params)
                    return {
                        name = 'CMake and Make Build',
                        strategy = {
                            'orchestrator',
                            tasks = {
                                {
                                    'build (cmake)',
                                    strategy = params.strategy,
                                },
                                { 'build (make)', strategy = params.strategy },
                            },
                        },
                    }
                end,
            },
            {
                name = 'build (cmake)',
                tags = { 'BUILD' },
                params = {
                    strategy = {
                        type = 'string',
                        optional = true,
                        default = tglt_default,
                    },
                },
                builder = function(params)
                    return {
                        name = 'CMake Build',
                        cmd = 'cmake',
                        args = { '-B', build, root },
                        strategy = params.strategy,
                    }
                end,
            },
            {
                name = 'build (make)',
                tags = { 'BUILD' },
                params = {
                    strategy = {
                        type = 'string',
                        optional = true,
                        default = tglt_default,
                    },
                },
                builder = function(params)
                    return {
                        name = 'Make Build',
                        cmd = 'make',
                        args = { '-C', build },
                        strategy = params.strategy,
                    }
                end,
            },
            {
                name = 'run',
                tags = { 'RUN' },
                builder = function()
                    return {
                        name = 'Make Run',
                        cmd = 'make',
                        args = { '--silent', '-C', build, 'run/fast' },
                    }
                end,
            },
        }
    end,
}