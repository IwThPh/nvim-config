" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " File Explorer
    Plug 'scrooloose/NERDTree'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'

    " Airline status
    Plug 'vim-airline/vim-airline'

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

    " Start Screen
    Plug 'mhinz/vim-startify'

	" Neovim LSP Config 
	Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'

	"""""""""""""""""""""""""
    " Themes
    """""""""""""""""""""""""
    "" Palenight Theme <3
	Plug 'drewtempelmeyer/palenight.vim'
	" One Dark/Light Theme 
	Plug 'rakr/vim-one'

call plug#end()
