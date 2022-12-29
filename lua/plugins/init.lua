vim.cmd("packadd packer.nvim")

local plugins = {
	["wbthomason/packer.nvim"] = {},

	["nvim-lua/plenary.nvim"] = { module = "plenary" },

	["tpope/vim-surround"] = {},

	["lewis6991/impatient.nvim"] = {},

	["MunifTanjim/nui.nvim"] = {},

	["NvChad/nvterm"] = {
		module = "nvterm",
		config = function()
			require("plugins.configs.nvterm")
		end,
	},

	["EdenEast/nightfox.nvim"] = {
		config = function()
			require("plugins.configs.nightfox")
		end,
	},

	["kyazdani42/nvim-web-devicons"] = {
		module = "nvim-web-devicons",
		config = function()
			require("plugins.configs.others").devicons()
		end,
	},

	["lukas-reineke/indent-blankline.nvim"] = {
		opt = true,
		setup = function()
			require("core.lazy_load").on_file_open("indent-blankline.nvim")
		end,
		config = function()
			require("plugins.configs.others").blankline()
		end,
	},

	["NvChad/nvim-colorizer.lua"] = {
		opt = true,
		setup = function()
			require("core.lazy_load").colorizer()
		end,
		config = function()
			require("plugins.configs.others").colorizer()
		end,
	},

	["nvim-treesitter/nvim-treesitter"] = {
		module = "nvim-treesitter",
		setup = function()
			require("core.lazy_load").on_file_open("nvim-treesitter")
		end,
		cmd = require("core.lazy_load").treesitter_cmds,
		run = ":TSUpdate",
		config = function()
			require("plugins.configs.treesitter")
		end,
	},

	-- git stuff
	["lewis6991/gitsigns.nvim"] = {
		opt = true,
		setup = function()
			require("core.lazy_load").gitsigns()
		end,
		config = function()
			require("plugins.configs.others").gitsigns()
		end,
	},

	["sindrets/diffview.nvim"] = {
		config = function()
			require("plugins.configs.diffview")
		end,
	},

	-- lsp stuff

	["williamboman/mason.nvim"] = {
		opt = true,
		cmd = require("core.lazy_load").lsp_cmds,
		setup = function()
			require("core.lazy_load").on_file_open("mason.nvim")
		end,
	},
	["williamboman/mason-lspconfig.nvim"] = {
		requires = "williamboman/mason.nvim",
	},

	["SmiteshP/nvim-navic"] = {
		requires = "neovim/nvim-lspconfig",
	},

	["neovim/nvim-lspconfig"] = {
		after = "mason.nvim",
		module = "lspconfig",
		config = function()
			require("plugins.configs.lsp_installer")
			require("plugins.configs.lspconfig")
		end,
	},

	-- load luasnips + cmp related in insert mode only

	["rafamadriz/friendly-snippets"] = {
		module = "cmp_nvim_lsp",
		event = "InsertEnter",
	},

	["hrsh7th/nvim-cmp"] = {
		after = "friendly-snippets",
		config = function()
			require("plugins.configs.cmp")
		end,
	},

	["L3MON4D3/LuaSnip"] = {
		wants = "friendly-snippets",
		after = "nvim-cmp",
		config = function()
			require("plugins.configs.others").luasnip()
		end,
	},

	["saadparwaiz1/cmp_luasnip"] = {
		after = "LuaSnip",
	},

	["hrsh7th/cmp-nvim-lua"] = {
		after = "cmp_luasnip",
	},

	["hrsh7th/cmp-nvim-lsp"] = {
		after = "cmp-nvim-lua",
	},

	["hrsh7th/cmp-buffer"] = {
		after = "cmp-nvim-lsp",
	},

	["hrsh7th/cmp-path"] = {
		after = "cmp-buffer",
	},

	-- misc plugins
	["windwp/nvim-autopairs"] = {
		after = "nvim-cmp",
		config = function()
			require("plugins.configs.others").autopairs()
		end,
	},

	["goolord/alpha-nvim"] = {
		disable = true,
		config = function()
			require("plugins.configs.alpha")
		end,
	},

	["numToStr/Comment.nvim"] = {
		module = "Comment",
		keys = { "gc", "gb" },
		config = function()
			require("plugins.configs.others").comment()
		end,
	},

	["nvim-neo-tree/neo-tree.nvim"] = {
		branch = "v2.x",
		-- cmd = { "NeoTree" },
		config = function()
			require("plugins.configs.neotree")
		end,
	},

	["rcarriga/nvim-notify"] = {
		config = function()
			require("plugins.configs.others").notify()
		end,
	},

	["nvim-telescope/telescope.nvim"] = {
		cmd = "Telescope",
		config = function()
			require("plugins.configs.telescope")
		end,
	},

	["romgrk/barbar.nvim"] = {
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("plugins.configs.barbar")
		end,
	},
	["rebelot/heirline.nvim"] = {
		config = function()
			require("plugins.configs.heirline")
		end,
	},

	["jose-elias-alvarez/null-ls.nvim"] = {
		module = "lspconfig",
		after = "nvim-lspconfig",
		config = function()
			require("plugins.configs.null-ls")
		end,
	},

	["j-hui/fidget.nvim"] = {
		module = "lspconfig",
		after = "nvim-lspconfig",
		config = function()
			require("fidget").setup({})
		end,
	},

	["vim-test/vim-test"] = {},

	["nvim-neotest/neotest"] = {
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
		},
	},

	["nvim-neotest/neotest-vim-test"] = {
		after = { "vim-test", "neotest" },
		config = function()
			require("neotest").setup({
				adapters = {
					-- Or to only allow specified file types
					require("neotest-vim-test")({ allow_file_types = { "php" } }),
				},
			})
		end,
	},

	-- Only load whichkey after all the gui
	["folke/which-key.nvim"] = {
		module = "which-key",
		config = function()
			require("plugins.configs.whichkey")
		end,
	},
}

require("core.packer").run(plugins)
