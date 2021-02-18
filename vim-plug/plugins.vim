" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
	" Status Line
    Plug 'glepnir/galaxyline.nvim'

	" Icons
	Plug 'ryanoasis/vim-devicons'
	" Plug 'kyazdani42/nvim-web-devicons' "Lua icons. Couldnt get working on dev build
    
    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'

    " Start Screen
    Plug 'mhinz/vim-startify'

    " File Explorer
	Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}

	" Buffer line 
	Plug 'akinsho/nvim-bufferline.lua'

	"Better buffer deletion
	" Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
	Plug 'ojroques/nvim-bufdel'

    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'

	" Vim surround
	Plug 'tpope/vim-surround'

	" Hex Colorizer
	Plug 'norcalli/nvim-colorizer.lua'

	" FZF - Fuzzy File Search
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'airblade/vim-rooter'
	Plug 'ojroques/nvim-lspfuzzy'

    " Commenting out lines easily
    Plug 'tpope/vim-commentary'

	" Git line edits...
	Plug 'mhinz/vim-signify'

    " Zen mode
    Plug 'junegunn/goyo.vim'

	" Neovim LSP Config 
	Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'
	Plug 'RRethy/vim-illuminate'

    " Neovim Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " update modules on update

	"Git 
	Plug 'tpope/vim-fugitive'

	" Testing
	Plug 'vim-test/vim-test'

	" Vista | LSP Symbol viewer
    Plug 'liuchengxu/vista.vim'
	
	"""""""""""""""""""""""""
    " Themes
    """""""""""""""""""""""""
    "" Palenight Theme <3
	" Plug 'drewtempelmeyer/palenight.vim'
	Plug 'christianchiarulli/nvcode-color-schemes.vim' " Better highlighting choices
	Plug 'ayu-theme/ayu-vim' 

	" One Dark/Light Theme 
	Plug 'rakr/vim-one'

call plug#end()
