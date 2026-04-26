local Terminal = require('toggleterm.terminal').Terminal
local shell = require 'overseer.shell'
local util = require 'overseer.util'

-- }}} Helpers {{{

local cleanup_autocmd
local all_channels = {}
local function register(job_id)
    if not cleanup_autocmd then
        cleanup_autocmd = vim.api.nvim_create_autocmd('VimLeavePre', {
            desc = 'Clean up running overseer tasks on exit',
            callback = function()
                local job_ids = vim.tbl_keys(all_channels)
                for _, chan_id in ipairs(job_ids) do
                    vim.fn.jobstop(chan_id)
                end

                -- make sure neovim doesn't exit
                -- until it has killed all child processes
                vim.fn.jobwait(job_ids)
            end,
        })
    end
    all_channels[job_id] = true
end

local function unregister(job_id)
    all_channels[job_id] = false
end

-- }}} ToggleTerm strategy {{{

---@class ToggletermStrategy
---@field term? table
local ToggletermStrategy = {}

function ToggletermStrategy.new()
    return setmetatable({ term = nil }, { __index = ToggletermStrategy })
end

function ToggletermStrategy:reset()
    if self.term then
        self.term:shutdown()
        self.term = nil
    end
end

function ToggletermStrategy:get_bufnr()
    return self.term and self.term.bufnr
end

function ToggletermStrategy:start(task)
    local stdout_iter = util.get_stdout_line_iter()
    local function on_stdout(data)
        -- send output to task
        task:dispatch('on_output', data)
        local lines = stdout_iter(data)
        if not vim.tbl_isempty(lines) then
            task:dispatch('on_output_lines', lines)
        end
    end

    local cmd = task.cmd
    if type(cmd) == 'table' then
        cmd = shell.escape_cmd(cmd, 'strong')
    end

    self.term = Terminal:new {
        cmd = cmd,
        env = task.env,
        dir = task.cwd,
        direction = 'horizontal',
        on_create = function(term)
            register(term.job_id)
        end,
        on_stdout = function(term, _, data)
            if term == self.term then
                on_stdout(data)
            end
        end,
        on_exit = function(term, job_id, code)
            unregister(job_id)

            if term ~= self.term then
                return
            end

            if vim.v.exiting == vim.NIL then
                task:on_exit(code)
            end
        end,
    }

    self.term:toggle()
end

function ToggletermStrategy:stop()
    if self.term and self.term.job_id then
        vim.fn.jobstop(self.term.job_id)
    end
end

function ToggletermStrategy:dispose()
    if self.term then
        self.term:shutdown()
        self.term = nil
    end
end

return {
    desc = 'Run tasks in toggleterm',
    constructor = function()
        return {
            on_init = function(_, task)
                task.strategy = ToggletermStrategy.new()
            end,
        }
    end,
}
