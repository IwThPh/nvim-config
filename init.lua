---------------------------------------------------------------
-- 	IwanThomPhil | init.vim
---------------------------------------------------------------

-- Initialise Lazy Nvim Package Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("plugins", {
	defaults = { lazy = true },
	install = { colorscheme = { "tokyonight" } },
	checker = { enabled = true },
	change_detection = {
		notify = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	-- debug = true,
})

require("core.options")
require("core.autocmds")
require("core.utils").load_mappings()

-- Load the configuration set above and apply the colorscheme
vim.cmd([[colorscheme terafox]])
