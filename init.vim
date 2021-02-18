"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 	IwanThomPhil | init.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keys/mappings.vim


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu
set wildmode=list:longest,list:full
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colours, Themes and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set colorcolumn=100

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
	set guifont=Fira\ Code:h12
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Source Theme
source $HOME/.config/nvim/themes/palenight.vim
lua require'plug-galaxyline'
lua require'plug-colorizer'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" try
"     set undodir=~/.vim/temp_dirs/undodir
"     set undofile
" catch
" endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('g:vscode')
	" VS Code extension
	source $HOME/.config/nvim/vscode/settings.vim
else
	lua require'plug-completion'
	lua require'plug-lsp'
	lua require'plug-test'
	lua require'plug-treesitter'
	lua require'plug-bufferline'
	lua require'plug-chadtree'

	source $HOME/.config/nvim/plug-config/vista.vim
	source $HOME/.config/nvim/plug-config/fzf.vim
	source $HOME/.config/nvim/plug-config/start-screen.vim
	source $HOME/.config/nvim/plug-config/signify.vim
	source $HOME/.config/nvim/plug-config/goyo.vim
endif

