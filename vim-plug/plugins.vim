" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
	" Deps
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'

	" Visual / UI Plugins
    Plug 'glepnir/galaxyline.nvim', {'branch' : 'main'} " Status Line
	Plug 'kyazdani42/nvim-web-devicons' " Icons
    Plug 'mhinz/vim-startify' " Start Screen
	Plug 'romgrk/barbar.nvim' " Buffer line 
	Plug 'norcalli/nvim-colorizer.lua'	" Hex Colorizer
	Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'} " File Explorer
    Plug 'junegunn/goyo.vim' " Zen mode

	" Quick Formatting/Editing
    Plug 'jiangmiao/auto-pairs' " Auto pairs for '(' '[' '{'
	Plug 'tpope/vim-surround' " Vim surround
    Plug 'tpope/vim-commentary' " Commenting out lines easily

    " Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " update modules on update

	" Fuzzy Finder
	Plug 'nvim-telescope/telescope.nvim'

	"Git 
	Plug 'tpope/vim-fugitive'
	Plug 'lewis6991/gitsigns.nvim'

	" Neovim LSP Config 
	Plug 'neovim/nvim-lspconfig' " Official LSP quick setup 
    Plug 'hrsh7th/nvim-compe' " Completion
	Plug 'RRethy/vim-illuminate' " Symbol highlighting
	Plug 'kosayoda/nvim-lightbulb' " VSCode like light bulb for code actions
    Plug 'liuchengxu/vista.vim' " Vista | LSP Symbol viewer

	" Start up time profilling
	Plug 'dstein64/vim-startuptime'

	" Debug/Testing
	Plug 'vim-test/vim-test'

    " Colourschemes
	Plug 'ayu-theme/ayu-vim' 
	Plug 'drewtempelmeyer/palenight.vim'
	Plug 'embark-theme/vim', { 'as': 'embark' }
	Plug 'jsit/toast.vim'
	Plug 'rakr/vim-one'
call plug#end()
