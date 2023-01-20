-------------------------------------------------------------
--                                                         --
--            .    _  _  _  /_ .//._   _  _/_              --
--           /|/|//_|/ //_// //////_/_\./_//_'|/           --
--                     /         /                         --
--                                                         --
--                                                         --
--  Neovim Config | Iwan Phillips <iwan@iwanphillips.dev>  --
-------------------------------------------------------------

-- Initialise Lazy Nvim Package Manager
require('core.options')
require('core.lazy')
require('core.mappings')
require('core.autocmds')
require('core.utils')

-- Load the configuration set above and apply the colorscheme
vim.cmd('colorscheme ' .. vim.g.theme)
