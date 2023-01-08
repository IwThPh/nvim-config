local set = vim.keymap.set

local function termcodes(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local M = {}

-- Macos alt key remaps
set({ 'n', 'v' }, '˙', '<M-h>')
set({ 'n', 'v' }, '∆', '<M-j>')
set({ 'n', 'v' }, '˚', '<M-k>')
set({ 'n', 'v' }, '¬', '<M-l>')

set('n', '<leader><leader>', '<cmd> w <CR>') -- , "﬚  save file"
set('n', '<leader><cr>', '<cmd> noh <CR>') -- , "  no highlight"
set('n', '<leader>cd', '<cmd> cd %:p:h<cr><cmd> pwd<cr>') -- , "🗎  change CWD"

set('n', '<C-h>', '<C-w>h') -- , "  window left"
set('n', '<C-l>', '<C-w>l') -- , "  window right"
set('n', '<C-j>', '<C-w>j') -- , "  window down"
set('n', '<C-k>', '<C-w>k') -- , "  window up"

set('n', '<M-h>', '<cmd> vertical resize -2<CR>') -- , "  decrease window width"
set('n', '<M-l>', '<cmd> vertical resize +2<CR>') -- , "  increase window width"
set('n', '<M-j>', '<cmd> resize -2<CR>') -- , "  decrease window height"
set('n', '<M-k>', '<cmd> resize +2<CR>') -- , "  increase window height"

set('n', '<leader>ss', ':setlocal spell!<cr>') -- , "  toggle spell checking"
set('n', '<leader>sn', ':setlocal spell!<cr>') -- , "  move to next spell error"
set('n', '<leader>sp', ':setlocal spell!<cr>') -- , "  move to previous spell error"
set('n', '<leader>sa', ':setlocal spell!<cr>') -- , "  add spelling to dictionary"
set('n', '<leader>so', '<cmd> Telescope spell_suggest <CR>') -- , "🕮   show spelling options"

set('n', '=', ':vsplit<cr>') -- , "❙  vertical split"
set('n', '-', ':split<cr>') -- , "―  horizontal split"

set('v', '>', '>gv') -- , "  increase indentation"
set('v', '<', '<gv') -- , "  decrease indentation"

set('t', '<C-x>', termcodes('<C-\\><C-N>')) -- , "   escape terminal mode"

set('n', '<TAB>', '<cmd> BufferNext <CR>') -- , "  goto next buffer" -- BufferNext
set('n', '<S-Tab>', '<cmd> BufferPrevious <CR> ') -- , "  goto prev buffer" -- BufferPrevious
set('n', '<leader>tp', '<cmd> tabprevious <CR>') -- , "  goto next tab"
set('n', '<leader>tn', '<cmd> tabnext <CR> ') -- , "  goto prev tab"
set('n', '<leader>q', '<cmd> BufferClose <CR>') -- , "   close buffer"

set('n', 'cc', '<Plug>(comment_toggle_linewise_current)') -- , "蘒  toggle comment"
set('v', 'c', '<Plug>(comment_toggle_linewise_visual)') -- , "蘒  toggle comment"

set('n', '<C-n>', '<cmd> NeoTreeFloatToggle <CR>') -- , "   toggle neotree"
set('n', '<leader>e', '<cmd> NeoTreeFocus <CR>') -- , "   focus neotree"

set('n', '<C-f>', '<cmd> Telescope find_files <CR>') -- , "  find files"
set('n', '<leader>ff', '<cmd> Telescope find_files <CR>') -- , "  find files"
set('n', '<leader>fa', '<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>') -- , "  find all"
set('n', '<leader>fw', '<cmd> Telescope live_grep <CR>') -- , "   live grep"
set('n', '<leader>fb', '<cmd> Telescope buffers <CR>') -- , "  find buffers"
set('n', '<leader>fh', '<cmd> Telescope help_tags <CR>') -- , "  help page"
set('n', '<leader>tk', '<cmd> Telescope keymaps <CR>') -- , "   show keys"
set('n', '<leader>qf', '<cmd> Telescope quickfix <CR>') -- , "   quickfix list"

-- git
set('n', '<leader>cm', '<cmd> Telescope git_commits <CR>') -- , "   git commits"
set('n', '<leader>gt', '<cmd> Telescope git_status <CR>') -- , "  git status"
set('n', '<leader>gs', '<cmd> Telescope git_branches <CR>') -- , "  show git branches"

set('n', '<leader>bc', function()
    local ok, start = require('indent_blankline.utils').get_current_context(
        vim.g.indent_blankline_context_patterns,
        vim.g.indent_blankline_use_treesitter_scope
    )

    if ok then
        vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
        vim.cmd([[normal! _]])
    end
end) -- , "  Jump to current_context"

set('n', ']c', function()
    if vim.wo.diff then
        return ']c'
    end
    vim.schedule(function()
        require('gitsigns').next_hunk()
    end)
    return '<Ignore>'
end) -- , "git next hunk"
set('n', 'c', function()
    if vim.wo.diff then
        return '[c'
    end
    vim.schedule(function()
        require('gitsigns').prev_hunk()
    end)
    return '<Ignore>'
end) -- , "git previous hunk"

set('n', '<leader>hs', function()
    require('gitsigns').stage_hunk()
end) -- , "git stage hunk"
set('n', '<leader>hu', function()
    require('gitsigns').undo_stage_hunk()
end) -- , "git unstage hunk"
set('n', '<leader>hr', function()
    require('gitsigns').reset_hunk()
end) -- , "git reset hunk"
set('n', '<leader>hp', function()
    require('gitsigns').preview_hunk()
end) -- , "git preview hunk"
set('n', '<leader>hb', function()
    require('gitsigns').blame_line()
end) -- , "git blame line"

set('n', 'tn', function()
    require('neotest').run.run()
end) -- , "run nearest test"
set('n', 'tf', function()
    require('neotest').run.run(vim.fn.expand('%'))
end) -- , "run all tests in file"
set('n', 'ta', function()
    require('neotest').run.run(vim.fn.getcwd())
end) -- , "run all tests"
set('n', 'tl', function()
    require('neotest').run.run_last()
end) -- , "run last test"
set('n', 'ts', function()
    require('neotest').summary.toggle()
end) -- , "toggle test summary"

M.lsp_mappings = function(opts)
    -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions
    set('n', 'gD', function()
        vim.lsp.buf.declaration()
    end, opts) --, "   lsp declaration",
    set('n', 'gd', '<cmd> Telescope lsp_definitions <CR>', opts) --, "   lsp definition",
    set('n', 'K', function()
        vim.lsp.buf.hover()
    end, opts) --, "   lsp hover",
    set('n', 'gi', '<cmd> Telescope lsp_implementations <CR>', opts) --, "   lsp implementation",
    set('n', '<leader>ls', function()
        vim.lsp.buf.signature_help()
    end, opts) --, "   lsp signature_help",
    set('n', '<leader>D', '<cmd> Telescope lsp_type_definitions <CR>', opts) --, "   lsp definition type",
    set('n', '<leader>ra', function()
        vim.lsp.buf.rename()
    end, opts) --, "   lsp rename",
    set('n', '<leader>ca', function()
        vim.lsp.buf.code_action()
    end, opts) --, "   lsp code_action",
    set('n', 'gr', '<cmd> Telescope lsp_references <CR>', opts) --, "   lsp references",
    set('n', '<leader>f', function()
        vim.diagnostic.open_float()
    end, opts) --, "   floating diagnostic",
    set('n', '[d', function()
        vim.diagnostic.goto_prev()
    end, opts) --, "   goto prev",
    set('n', 'd]', function()
        vim.diagnostic.goto_next()
    end, opts) --, "   goto_next",
    set('n', '<leader>fm', function()
        vim.lsp.buf.format({ async = true })
    end, opts) --, "   lsp formatting",
    set('n', '<leader>wa', function()
        vim.lsp.buf.add_workspace_folder()
    end, opts) --, "   add workspace folder",
    set('n', '<leader>wr', function()
        vim.lsp.buf.remove_workspace_folder()
    end, opts) --, "   remove workspace folder",
    set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts) --, "   list workspace folders",
end

return M
