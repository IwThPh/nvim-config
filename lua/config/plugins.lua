local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

return require('packer').startup {
	function(use)
		-- Packer can manage itself as an optional plugin
		use 'wbthomason/packer.nvim'

		-- Deps
		use 'nvim-lua/plenary.nvim' 
		use 'nvim-lua/popup.nvim' 

		-- Visual / UI
		use {										-- Status line
			'glepnir/galaxyline.nvim', branch = 'main', 
			requires = {'kyazdani42/nvim-web-devicons'}
		}
		use 'mhinz/vim-startify' 					-- Start Screen
		use 'romgrk/barbar.nvim' 					-- Buffer line 
		use 'norcalli/nvim-colorizer.lua' 			-- Hex Colorizer
		use {										-- File explorer
			'kyazdani42/nvim-tree.lua', 
			requires = {'kyazdani42/nvim-web-devicons'}
		}
		use 'junegunn/goyo.vim' 					-- Focus mode

		-- Quick Formatting/Editing
		use 'jiangmiao/auto-pairs' 					-- Auto pairs for '(' '[' '{'
		use 'tpope/vim-surround' 					-- Surround selection
		use 'tpope/vim-commentary' 					-- Commenting out lines easily

		-- Treesitter
		use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

		-- Fuzzy Finder
		use {										-- Extensible Fuzzy Finder
			'nvim-telescope/telescope.nvim',
			require = { 
				{ 'nvim-lua/plenary.nvim' },
				{ 'nvim-lua/popup.nvim' }, 
			}
		}
		use 'nvim-telescope/telescope-fzf-writer.nvim'
		use 'nvim-telescope/telescope-dap.nvim'

		-- Git 
		use 'tpope/vim-fugitive'
		use {
			'lewis6991/gitsigns.nvim',
			require = { 'nvim-lua/plenary.nvim' }
		}

		-- Neovim LSP Config 
		use 'neovim/nvim-lspconfig' 				-- Official LSP quick setup 
		use 'nvim-lua/lsp_extensions.nvim' 			-- see plugins.lsp.extensions
		use 'hrsh7th/nvim-compe' 					-- Auto-completion
		use 'RRethy/vim-illuminate' 				-- Symbol hover highlighting
		use 'kosayoda/nvim-lightbulb' 				-- VSCode like light bulb for code actions
		use 'liuchengxu/vista.vim' 					-- Symbol viewer
		use 'glepnir/lspsaga.nvim' 					-- Handlers, see plugins.lsp.handlers

		-- Start up time profilling
		use 'dstein64/vim-startuptime'

		-- Project rooting
		use 'airblade/vim-rooter'

		-- Debug/Testing
		use 'vim-test/vim-test'						-- Test runner
		use 'mfussenegger/nvim-dap'					-- Debug Adapter Protocol

		-- Colourschemes
		use 'ayu-theme/ayu-vim' 
		use 'drewtempelmeyer/palenight.vim'
		use { 'embark-theme/vim', as = 'embark' }
		use 'jsit/toast.vim'
		use 'rakr/vim-one'
	end,
	config = {
		_display = {
			open_fn = function(name)
				-- Can only use plenary when we have our plugins.
				--  We can only get plenary when we don't have our plugins ;)
				local ok, float_win = pcall(function()
					return require('plenary.window.float').percentage_range_window(0.8, 0.8)
				end)

				if not ok then
					vim.cmd [[65vnew  [packer] ]]

					return vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
				end

				local bufnr = float_win.bufnr
				local win = float_win.win_id

				vim.api.nvim_buf_set_name(bufnr, name)
				vim.api.nvim_win_set_option(win, 'winblend', 10)

				return win, bufnr
			end
		},
	}
}
