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

" Source Theme
source $HOME/.config/nvim/themes/embark.vim
lua require'plug-galaxyline'
lua require'plug-colorizer'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:python3_host_prog = '/Users/iwanphillips/.pyenv/versions/neovim3/bin/python'

if exists('g:vscode')
	" VS Code extension
	source $HOME/.config/nvim/vscode/settings.vim
else
	lua require'plug-completion'
	lua require'plug-lsp'
	lua require'plug-test'
	lua require'plug-treesitter'
	lua require'plug-chadtree'

	source $HOME/.config/nvim/plug-config/vista.vim
	source $HOME/.config/nvim/plug-config/fzf.vim
	source $HOME/.config/nvim/plug-config/start-screen.vim
	source $HOME/.config/nvim/plug-config/signify.vim
	source $HOME/.config/nvim/plug-config/goyo.vim
endif

