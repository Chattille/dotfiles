local buf_get_real_base = require('util.files').buf_get_real_base

---Get the top root directory for CMake projects.
---
---@return string? # Root path.
local function get_cmake_root()
    local paths = vim.fs.find('CMakeLists.txt', {
        path = buf_get_real_base(),
        upward = true,
        stop = '~',
        type = 'file',
        limit = math.huge,
    })
    return vim.fs.dirname(paths[#paths])
end

return {
    condition = { filetype = { 'c', 'cpp' } },
    generator = function()
        local root = get_cmake_root()
        if not root then
            return '[Template cmake] Root directory not found'
        end

        local build = root .. '/build'

        local run = {
            name = 'Make Run',
            cmd = { 'make', '--silent', '-C', build, 'run/fast' },
        }
        local make_build = {
            name = 'Make Build',
            cmd = { 'make', '-C', build },
        }
        local cmake_build = {
            name = 'CMake Build',
            cmd = { 'cmake', '-B', build, root },
        }

        local classic = { components = { 'classic' } }

        local cmake_build_classic =
            vim.tbl_deep_extend('keep', classic, cmake_build)
        local make_build_classic =
            vim.tbl_deep_extend('keep', classic, make_build)

        return {
            {
                name = '@build & run',
                tags = { 'BUILD', 'RUN', 'DEFAULT' },
                builder = function()
                    return {
                        name = 'Build and Run',
                        strategy = {
                            'orchestrator',
                            tasks = {
                                cmake_build_classic,
                                make_build_classic,
                                run,
                            },
                        },
                        components = { 'classic' },
                    }
                end,
            },
            {
                name = 'build (cmake & make)',
                tags = { 'BUILD' },
                builder = function()
                    return {
                        name = 'CMake and Make Build',
                        strategy = {
                            'orchestrator',
                            tasks = {
                                cmake_build_classic,
                                make_build_classic,
                            },
                        },
                        components = { 'classic' },
                    }
                end,
            },
            {
                name = 'build (cmake)',
                tags = { 'BUILD' },
                builder = function()
                    return cmake_build
                end,
            },
            {
                name = 'build (make)',
                tags = { 'BUILD' },
                builder = function()
                    return make_build
                end,
            },
            {
                name = 'run',
                tags = { 'RUN' },
                builder = function()
                    return run
                end,
            },
        }
    end,
}
