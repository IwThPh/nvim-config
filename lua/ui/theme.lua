local M = {}

local palette = require('nightfox.palette').load(vim.g.theme)

M.load_highlight = function(group)
   if type(group) == "string" then
      group = require("ui.custom." .. group)
   end

   for hl, col in pairs(group) do
      vim.api.nvim_set_hl(0, hl, col)
   end
end

-- See https://github.com/EdenEast/nightfox.nvim/blob/main/usage.md#palette
M.get_palette = function () return palette end

return M
