local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local bufcheck = augroup('bufcheck', { clear = true })

-- Highlight on yank
autocmd('TextYankPost', {
    group = bufcheck,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({ timeout = 300 })
    end,
})

-- Start terminal in INSERT mode
autocmd('TermOpen', {
    group = bufcheck,
    pattern = '*',
    command = 'startinsert | set winfixheight',
})

-- Start git commits in INSERT mode
-- autocmd('FileType', {
-- 	group = bufcheck,
-- 	pattern = { 'gitcommit', 'gitrebase' },
-- 	command = 'startinsert',
-- })

autocmd('FileType', {
    group = bufcheck,
    pattern = { 'gitcommit', 'gitrebase', 'markdown' },
    command = 'setlocal spell',
})

autocmd('User', {
    group = bufcheck,
    pattern = { 'TelescopeFindPre' },
    callback = function()
        local winnr = vim.api.nvim_get_current_win()
        vim.wo[winnr].statuscolumn = nil
    end,
})

autocmd('FileType', {
    group = bufcheck,
    pattern = { 'lazy', 'help', 'terminal', 'lspinfo', 'Telescope', 'TelescopePrompt', 'TelescopeResults', 'Mason', '' },
    callback = function()
        local winnr = vim.api.nvim_get_current_win()
        vim.wo[winnr].statuscolumn = nil
    end,
})

autocmd('FocusLost', {
    group = bufcheck,
    command = 'wa',
})

-- Return to last position...
autocmd('BufReadPost', {
    group = bufcheck,
    pattern = '*',
    callback = function()
        local fn = vim.fn
        if fn.line('\'"') > 0 and fn.line('\'"') <= fn.line('$') then
            fn.setpos('.', fn.getpos('\'"'))
        end
    end,
})

-- Don't auto commenting new lines
autocmd('BufEnter', {
    pattern = '*',
    command = 'set fo-=c fo-=r fo-=o',
})
