---------------------------------------------------------------
-- 	IwanThomPhil | init.vim
---------------------------------------------------------------

require "core"
require "core.options"

vim.defer_fn(function()
	require("core.utils").load_mappings()
end, 0)

require("core.packer").bootstrap()
require "plugins"

require('ui.theme').generate_user_config_highlights()

-- -- Load the configuration set above and apply the colorscheme
vim.cmd([[colorscheme terafox]])
