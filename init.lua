---------------------------------------------------------------
-- 	IwanThomPhil | init.vim
---------------------------------------------------------------

-- Initialise Lazy Nvim Package Manager
require("core.options")

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
	defaults = { lazy = false },
	install = { colorscheme = { vim.g.theme } },
	checker = { enabled = true },
	change_detection = { notify = false },
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

require("core.autocmds")
require("core.utils").load_mappings(require("core.mappings"))

-- Load the configuration set above and apply the colorscheme
vim.cmd("colorscheme " .. vim.g.theme)
