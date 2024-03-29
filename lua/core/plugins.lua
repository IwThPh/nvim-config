local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	execute("packadd packer.nvim")
end

require("packer").startup(
	function(use)
		-- Packer can manage itself as an optional plugin
		use("wbthomason/packer.nvim")

		-- Visual / UI
		use "rebelot/heirline.nvim"
		use({
			"folke/persistence.nvim",
			event = "BufReadPre", -- this will only start session saving when an actual file was opened
			module = "persistence",
			config = function()
				require("persistence").setup()
			end,
		})
		use("romgrk/barbar.nvim") -- Buffer line
		use("norcalli/nvim-colorizer.lua") -- Hex Colorizer
		-- use({ -- File explorer
		-- 	"kyazdani42/nvim-tree.lua",
		-- 	requires = { "kyazdani42/nvim-web-devicons" },
		-- })
		use({
			"rcarriga/nvim-notify", 
			config = function ()
				local notify = require'notify'
				vim.notify = notify
				notify.setup({ stages = "slide" })
			end
		}) -- Notifications

		use({ -- File explorer
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
		use({
			"nacro90/numb.nvim", -- Line viewer E.g. {:number}
			config = function()
				require("numb").setup()
			end,
		})
		use("lukas-reineke/indent-blankline.nvim")
		use({
			"vuki656/package-info.nvim", -- Line viewer E.g. {:number}
			requires = "MunifTanjim/nui.nvim",
			config = function()
				require("package-info").setup()
			end,
		})
		use("gelguy/wilder.nvim")
		use({
			"luukvbaal/stabilize.nvim",
			config = function()
				require("stabilize").setup()
			end,
		})

		-- Quick Formatting/Editing
		use({
			"windwp/nvim-autopairs", -- Auto pairs for '(' '[' '{'
			config = function()
				require("nvim-autopairs").setup()
			end,
		})
		use("tpope/vim-surround") -- Surround selection
		use({ "numToStr/Comment.nvim", config = function() require 'Comment'.setup() end }) -- Commenting out lines easily

		-- Treesitter
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

		-- Fuzzy Finder
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
		use({ -- Extensible Fuzzy Finder
			"nvim-telescope/telescope.nvim",
			require = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-lua/popup.nvim" },
			},
		})
		use("nvim-telescope/telescope-dap.nvim")

		-- Git
		use("tpope/vim-fugitive")
		use({
			"lewis6991/gitsigns.nvim",
			require = { "nvim-lua/plenary.nvim" },
		})
		use("sindrets/diffview.nvim")

		-- Neovim LSP Config
		use("neovim/nvim-lspconfig") -- Official LSP quick setup
		use("williamboman/nvim-lsp-installer")
		use("nvim-lua/lsp_extensions.nvim") -- see plugins.lsp.extensions
		use({ -- Auto-completion
			"hrsh7th/nvim-cmp",
			requires = {
				{ "hrsh7th/vim-vsnip" },
				{ "hrsh7th/cmp-vsnip" },
				{ "rafamadriz/friendly-snippets" },
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "hrsh7th/cmp-buffer" }, -- Install the buffer completion source
			},
		})
		use({
			"jose-elias-alvarez/null-ls.nvim",
			require = {
				{ "nvim-lua/plenary.nvim" },
				{ "neovim/nvim-lspconfig" },
			},
		})
		use({
			"jose-elias-alvarez/nvim-lsp-ts-utils",
			require = {
				{ "neovim/nvim-lspconfig" },
				{ "jose-elias-alvarez/null-ls.nvim" },
			},
		})
		use({
			"j-hui/fidget.nvim",
			config = function()
				require("fidget").setup({})
			end,
		})

		use("lewis6991/impatient.nvim")

		use("onsails/lspkind-nvim") -- Completion icons.
		use({
			"folke/lsp-trouble.nvim", -- LSP Diagnostics list
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
			"folke/lsp-colors.nvim", -- LSP Diagnostics colour auto linking
			config = function()
				require("lsp-colors").setup()
			end,
		})

		-- Sidebar (like symbols-outline and vista)
		use("sidebar-nvim/sidebar.nvim")

		-- Start up time profilling
		use("dstein64/vim-startuptime")

		-- Project rooting
		use("airblade/vim-rooter")

		-- Debug/Testing
		use("vim-test/vim-test") -- Test runner
		use("mfussenegger/nvim-dap") -- Debug Adapter Protocol

		-- Colourschemes
		use("marko-cerovac/material.nvim")
		use("folke/tokyonight.nvim")
		use("EdenEast/nightfox.nvim")
		use("wuelnerdotexe/vim-enfocado")
	end
)
