local Util = require("custom.util")

---@class custom.util.telescope.opts
---@field cwd? string|boolean
---@field show_untracked? boolean

---@class custom.util.telescope
---@overload fun(builtin:string, opts?:custom.util.telescope.opts)
local M = setmetatable({}, {
  __call = function(m, ...)
    return m.telescope(...)
  end,
})

-- this will return a function that calls telescope.
-- cwd will default to custom.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
---@param builtin string
---@param opts? custom.util.telescope.opts
function M.telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts
    opts = vim.tbl_deep_extend("force", { cwd = Util.root() }, opts or {}) --[[@as custom.util.telescope.opts]]
    if builtin == "files" then
      if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
        opts.show_untracked = true
        builtin = "git_files"
      else
        builtin = "find_files"
      end
    end
    if opts.cwd and opts.cwd ~= vim.loop.cwd() then
      ---@diagnostic disable-next-line: inject-field
      opts.attach_mappings = function(_, map)
        map("i", "<a-c>", function()
          local action_state = require("telescope.actions.state")
          local line = action_state.get_current_line()
          M.telescope(
            params.builtin,
            vim.tbl_deep_extend("force", {}, params.opts or {}, { cwd = false, default_text = line })
          )()
        end)
        return true
      end
    end

    require("telescope.builtin")[builtin](M.theme(params.opts))
  end
end

function M.config_files()
  return Util.telescope("find_files", { cwd = vim.fn.stdpath("config") })
end

function M.theme(opts)
  return vim.tbl_deep_extend("force", {}, require('telescope.themes').get_ivy({
    winblend = 5,
    border = true,
    borderchars = {
      "z",
      prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
      results = { " " },
      preview = { " " },
    },

    layout_config = {
      height = 0.6,
    },
  }), opts or {})
end

return M
