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

	{
		"lukas-reineke/indent-blankline.nvim",
		lazy = true,
		init = function()
			require("core.lazy_load").on_file_open("indent-blankline.nvim")
		end,
		config = function()
			require("plugins.others").blankline()
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		setup = function()
			require("core.lazy_load").on_file_open("nvim-treesitter")
		end,
		cmd = require("core.lazy_load").treesitter_cmds,
		run = ":TSUpdate",
		config = function()
			require("plugins.treesitter")
		end,
	},

	-- git stuff
	{
		"lewis6991/gitsigns.nvim",
		opt = true,
		setup = function()
			require("core.lazy_load").gitsigns()
		end,
		config = function()
			require("plugins.others").gitsigns()
		end,
	},

	{
		"sindrets/diffview.nvim",
		config = function()
			require("plugins.diffview")
		end,
	},

	-- lsp stuff

	{
		"williamboman/mason.nvim",
		opt = true,
		cmd = require("core.lazy_load").lsp_cmds,
		setup = function()
			require("core.lazy_load").on_file_open("mason.nvim")
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		requires = "williamboman/mason.nvim",
	},

	{
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = { "mason.nvim" },
		config = function()
			require("plugins.lsp_installer")
			require("plugins.lspconfig")
		end,
	},

	-- load luasnips + cmp related in insert mode only
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"rafamadriz/friendly-snippets",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("plugins.cmp")
		end,
	},

	-- misc plugins
	{
		"windwp/nvim-autopairs",
		config = function()
			require("plugins.others").autopairs()
		end,
	},

	{
		"numToStr/Comment.nvim",
		keys = { "gc", "gb" },
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		-- cmd = { "NeoTree" },
		config = function()
			require("plugins.neotree")
		end,
	},

	{
		"rcarriga/nvim-notify",
		config = function()
			require("plugins.others").notify()
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		config = function()
			require("plugins.telescope")
		end,
	},

	{
		"romgrk/barbar.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("plugins.barbar")
		end,
	},
	{
		"rebelot/heirline.nvim",
		config = function()
			require("plugins.heirline")
		end,
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lspconfig" },
		config = function()
			require("plugins.null-ls")
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
		requires = {
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

	-- Only load whichkey dependencies all the gui
	{
		"folke/which-key.nvim",
		config = function()
			require("plugins.whichkey")
		end,
	},
}
