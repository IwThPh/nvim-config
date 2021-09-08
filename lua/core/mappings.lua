local function nmap(key, cmd, opts)
	U.keymap.map('n', key, cmd, opts)
end
local function imap(key, cmd, opts)
	U.keymap.map('i', key, cmd, opts)
end
local function vmap(key, cmd, opts)
	U.keymap.map('v', key, cmd, opts)
end
local function xmap(key, cmd, opts)
	U.keymap.map('x', key, cmd, opts)
end
local function tmap(key, cmd, opts)
	U.keymap.map('t', key, cmd, opts)
end
local function cmap(key, cmd, opts)
	U.keymap.map('c', key, cmd, opts)
end

vim.g.mapleader = " "

-- Quick Save and Quit.
nmap('<leader><leader>',':w<CR>')
nmap('<leader>q', ':BufferClose<CR>')

-- Disable highlight when <leader><cr> is pressed
nmap('<leader><cr>', ':noh<cr>')

-- Buffer mappings
-- Smart way to move between windows
nmap('<C-j>', '<C-W>j')
nmap('<C-k>', '<C-W>k')
nmap('<C-h>', '<C-W>h')
nmap('<C-l>', '<C-W>l')

-- Use alt + hjkl to resize windows
nmap('<M-j>', '<cmd>resize -2<CR>')
nmap('<M-k>', '<cmd>resize +2<CR>')
nmap('<M-h>', '<cmd>vertical resize -2<CR>')
nmap('<M-l>', '<cmd>vertical resize +2<CR>')

-- TAB in general mode will move to text buffer
nmap('<TAB>', '<cmd>BufferNext<CR>')
-- SHIFT-TAB will go back
nmap('<S-TAB>', '<cmd>BufferPrevious<CR>')

-- Map escape to escape sequence in terminal buffer.
tmap('<Esc>', '<C-\\><C-n>')

-- Useful mappings for managing tabs
nmap('<leader>tn','<cmd>tabnew<cr>')
nmap('<leader>to','<cmd>tabonly<cr>')
nmap('<leader>tc','<cmd>tabclose<cr>')
nmap('<leader>tm','<cmd>tabmove')
nmap('<leader>t<leader>', '<cmd>tabnext<cr>')

-- Switch CWD to the directory of the open buffer
nmap('<leader>cd', '<cmd>cd %:p:h<cr><cmd>pwd<cr>')

-- Return to last edit position when opening files (You want this!)
vim.cmd [[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]

-- Open current file in a new vertical split with '='
nmap('=', ':vsplit<cr>')

-- Quickly open a markdown buffer for scribble
nmap('<leader>n', ':e ~/buffer.md<cr>')

-- EASY CAPS
imap('<C-u>','<ESC>viwUi')
nmap('<C-u>','viwU<Esc>')

-- Use <Tab> and <S-Tab> to navigate through popup menu
imap('<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true})
imap('<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { expr = true})

-- Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap('<M-J>',"mz:m+<cr>`z")
nmap('<M-K>',"mz:m-2<cr>`z")
vmap('<M-j>',":m'>+<cr>`<my`>mzgv`yo`z")
vmap('<M-k>',":m'<-2<cr>`>my`<mzgv`yo`z")

nmap('˙','<M-h>')
nmap('∆','<M-j>')
nmap('˚','<M-k>')
nmap('¬','<M-l>')
vmap('˙','<M-h>')
vmap('∆','<M-j>')
vmap('˚','<M-k>')
vmap('¬','<M-l>')

-- Better tabbing
vmap('<','<gv')
vmap('>','>gv')

-- Back to escape mode
imap('jk','<Esc>')
imap('kj','<Esc>')

-- Spell checking
-- Pressing ,ss will toggle and untoggle spell checking
nmap('<leader>ss', ':setlocal spell!<cr>')

-- Shortcuts using <leader>
nmap('<leader>sn',']s')
nmap('<leader>sp','[s')
nmap('<leader>sa','zg')
-- Spelling suggest moved to telescope mappings
