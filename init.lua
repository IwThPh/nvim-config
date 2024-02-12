-------------------------------------------------------------
--            .    _  _  _  /_ .//._   _  _/_              --
--           /|/|//_|/ //_// //////_/_\./_//_'|/           --
--                     /         /                         --
--  Neovim Config | Iwan Phillips <iwan@iwanphillips.dev>  --
-------------------------------------------------------------

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Install package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- vim options
require("config.options")

-- configure plugins
require("lazy").setup({
  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",

  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim",  opts = {} },

  { import = "custom.plugins" },
}, {})

require("config.keymaps")
require("config.autocmds")
