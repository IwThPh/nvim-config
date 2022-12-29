return {
	"wbthomason/packer.nvim",
	"nvim-lua/plenary.nvim",
	"tpope/vim-surround",
	"lewis6991/impatient.nvim",
	"MunifTanjim/nui.nvim",

	{
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({ override = require("ui.icons").devicons })
		end,
	},

		"numToStr/Comment.nvim",

	{
		"rcarriga/nvim-notify",
		config = function()
			local notify = require("notify")
			vim.notify = notify
			notify.setup({ stages = "slide" })
		end,
	},

	{
		"j-hui/fidget.nvim",
		dependencies = { "nvim-lspconfig" },
		config = function()
			require("fidget").setup({})
		end,
	},

	"vim-test/vim-test",

	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
		},
	},

	{
		"nvim-neotest/neotest-vim-test",
		dependencies = { "vim-test", "neotest" },
		config = function()
			require("neotest").setup({
				adapters = {
					-- Or to only allow specified file types
					require("neotest-vim-test")({ allow_file_types = { "php" } }),
				},
			})
		end,
	},
}
