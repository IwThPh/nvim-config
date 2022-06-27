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

-- -- Load the configuration set above and apply the colorscheme
local nightfox = require("nightfox")
nightfox.setup({
	options = {
		transparent = false,
		terminal_color = true,
		styles = {
			comments = "italic", -- change style of comments to be italic
			keywords = "bold", -- change style of keywords to be bold
			functions = "italic,bold", -- styles can be a comma separated list
		},
		inverse = {
			-- match_paren = true, -- Enable/Disable inverse highlighting for match parens
			-- visual = true, -- Enable/Disable inverse highlighting for visual selection
			-- search = true, -- Enable/Disable inverse highlights for search highlights
		},
	},
})

-- -- Load the configuration set above and apply the colorscheme
vim.cmd([[colorscheme terafox]])
