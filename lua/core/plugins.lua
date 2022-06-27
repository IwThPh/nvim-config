use({
	"",
	config = function()
		local notify = require 'notify'
		vim.notify = notify
		notify.setup({ stages = "slide" })
	end
})

use({
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v2.x",
	requires = {
		"nvim-lua/plenary.nvim",
		"kyazdani42/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
})

use("folke/zen-mode.nvim")
use("folke/twilight.nvim")
use("gelguy/wilder.nvim")
use({
	"luukvbaal/stabilize.nvim",
	config = function()
		require("stabilize").setup()
	end,
})

use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
use({
	"nvim-telescope/telescope.nvim",
	require = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-lua/popup.nvim" },
	},
})
use("nvim-telescope/telescope-dap.nvim")


use("tpope/vim-fugitive")
use({
	"lewis6991/gitsigns.nvim",
	require = { "nvim-lua/plenary.nvim" },
})
use("sindrets/diffview.nvim")


use("nvim-lua/lsp_extensions.nvim")
use({
	"jose-elias-alvarez/null-ls.nvim",
})
use({
	"j-hui/fidget.nvim",
	config = function()
		require("fidget").setup({})
	end,
})

use("onsails/lspkind-nvim")

use({
	"folke/lsp-trouble.nvim",
	requires = "kyazdani42/nvim-web-devicons",
})

use({
	"folke/todo-comments.nvim",
	requires = "nvim-lua/plenary.nvim",
	config = function()
		require("todo-comments").setup({})
	end,
})

use({
	"folke/lsp-colors.nvim",
	config = function()
		require("lsp-colors").setup()
	end,
})


use("airblade/vim-rooter")


use("vim-test/vim-test")
use("mfussenegger/nvim-dap")


use("EdenEast/nightfox.nvim")
