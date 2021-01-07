
" TODO: file specific, maybe LSP with Git at Root?

noremap <silent><buffer> <leader>cb :BlamerToggle<CR>


let g:blamer_enabled = 1

let g:blamer_delay = 500

let g:blamer_show_in_visual_modes = 0
let g:blamer_show_in_insert_modes = 0

let g:blamer_prefix = ' | '

" Other Options: <author>, <author-mail>, <author-time>, <committer>, <committer-mail>, <committer-time>, <summary>, <commit-short>, <commit-long>
let g:blamer_template = '<committer>, <committer-time> • <summary>'

let g:blamer_date_format = '%d/%m/%y'

" highlight Blamer guifg=lightgrey

