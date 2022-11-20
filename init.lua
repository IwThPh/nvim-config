---------------------------------------------------------------
-- 	IwanThomPhil | init.vim
---------------------------------------------------------------

require("core.options")
require("core.autocmds")
require("core.utils").load_mappings()
require("core.packer").bootstrap()
require("plugins")

-- Load the configuration set above and apply the colorscheme
vim.cmd([[colorscheme terafox]])
