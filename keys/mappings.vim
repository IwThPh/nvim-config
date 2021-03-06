" Quick Save and Quit.
map <Leader><Leader> :w<CR>
map <Leader>q :BufferClose<CR>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>


if exists('g:vscode')

  " Simulate same TAB behavior in VSCode
  nmap <Tab> :Tabnext<CR>
  nmap <S-Tab> :Tabprev<CR>

else

	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" => Buffer mappings
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

	" Smart way to move between windows
	map <C-j> <C-W>j
	map <C-k> <C-W>k
	map <C-h> <C-W>h
	map <C-l> <C-W>l

	" Use alt + hjkl to resize windows
	nnoremap <M-j>    :resize -2<CR>
	nnoremap <M-k>    :resize +2<CR>
	nnoremap <M-h>    :vertical resize -2<CR>
	nnoremap <M-l>    :vertical resize +2<CR>

	" TAB in general mode will move to text buffer
	nnoremap <TAB> :BufferNext<CR>
	" SHIFT-TAB will go back
	nnoremap <S-TAB> :BufferPrevious<CR> 

	" Map escape to escape sequence in terminal buffer.
	:tnoremap <Esc> <C-\><C-n>

	" Useful mappings for managing tabs
	map <leader>tn :tabnew<cr>
	map <leader>to :tabonly<cr>
	map <leader>tc :tabclose<cr>
	map <leader>tm :tabmove
	map <leader>t<leader> :tabnext<cr>

	" Switch CWD to the directory of the open buffer
	map <leader>cd :cd %:p:h<cr>:pwd<cr>

	" Return to last edit position when opening files (You want this!)
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

	" Open current file in a new vertical split with '='
	nnoremap = :vsplit<cr>

	" Quickly open a markdown buffer for scribble
	map <leader>n :e ~/buffer.md<cr>


	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" => Editing mappings
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

	" EASY CAPS
	inoremap <C-u> <ESC>viwUi
	nnoremap <C-u> viwU<Esc>

	" Use <Tab> and <S-Tab> to navigate through popup menu
	inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
	inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
endif

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-J> mz:m+<cr>`z
nmap <M-K> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap ˙ <M-h>
  nmap ∆ <M-j>
  nmap ˚ <M-k>
  nmap ¬ <M-l>
  vmap ˙ <M-h>
  vmap ∆ <M-j>
  vmap ˚ <M-k>
  vmap ¬ <M-l>
endif

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Back to escape mode
inoremap jk <Esc>
inoremap kj <Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


