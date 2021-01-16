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
    Plug 'scrooloose/NERDTree'
	Plug 'Xuyuanp/nerdtree-git-plugin'

    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'

	" Hex Colorizer
	Plug 'norcalli/nvim-colorizer.lua'

	" FZF - Fuzzy File Search
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'airblade/vim-rooter'

    " Commenting out lines easily
    Plug 'tpope/vim-commentary'

	" Git line edits...
	Plug 'mhinz/vim-signify'

    " Zen mode
    Plug 'junegunn/goyo.vim'

	" Neovim LSP Config 
	Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
	Plug 'RRethy/vim-illuminate'

    " Neovim Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " update modules on update

	"Git Blame
	Plug 'APZelos/blamer.nvim'

	" Vista | LSP Symbol viewer
    Plug 'liuchengxu/vista.vim'
	
	"""""""""""""""""""""""""
    " Themes
    """""""""""""""""""""""""
    "" Palenight Theme <3
	Plug 'drewtempelmeyer/palenight.vim'
	" One Dark/Light Theme 
	Plug 'rakr/vim-one'

call plug#end()
