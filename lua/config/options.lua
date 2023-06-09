-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.breakindent = true -- maintain indent when wrapping indented lines
opt.fillchars = { eob = " " }
opt.relativenumber = false
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.spelllang = { "en_gb" }
opt.whichwrap:append("<,>,[,],h,l")
opt.list = true
opt.listchars = { trail = "·", tab = "▸ " } -- eol = '↴',
