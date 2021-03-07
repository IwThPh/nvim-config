"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 	IwanThomPhil | init.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require'config.globals'
lua require'config.plugins'

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
lua require'plugin.galaxyline'
lua require'plugin.colorizer'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:python3_host_prog = '/Users/iwanphillips/.pyenv/versions/neovim3/bin/python'

if exists('g:vscode')
	" VS Code extension
	source $HOME/.config/nvim/vscode/settings.vim
else
	lua require'plugin.completion'
	lua require'plugin.lsp'
	lua require'plugin.telescope'
	lua require'plugin.telescope.mapping'
	lua require'plugin.test'
	lua require'plugin.treesitter'
	lua require'plugin.chadtree'
	lua require'plugin.gitsigns'

	source $HOME/.config/nvim/plug-config/vista.vim
	source $HOME/.config/nvim/plug-config/start-screen.vim
	source $HOME/.config/nvim/plug-config/goyo.vim
endif

