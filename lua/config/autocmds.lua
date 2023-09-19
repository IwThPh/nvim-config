local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local bufcheck = augroup("bufcheck", { clear = true })

autocmd("FocusLost", {
  group = bufcheck,
  command = "wa",
})
