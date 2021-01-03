let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

map <leader>nf :NERDTreeFocus<cr>
map <leader>nt :NERDTreeToggle<cr>

" Open nodes with l and close with h
let NERDTreeMapActivateNode='l'
let NERDTreeMapCloseDir='h'


"" Git plugin. 
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✹',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
				\ }

let g:NERDTreeGitStatusUseNerdFonts = 1 

