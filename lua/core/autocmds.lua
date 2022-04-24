local fn = vim.fn
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('bufcheck', { clear = true })

-- Highlight on yank
autocmd('TextYankPost', {
	group = 'bufcheck',
	pattern =  '*',
	callback = function() vim.highlight.on_yank({ timeout = 300 }) end,
})

-- Start terminal in INSERT mode
autocmd('TermOpen', {
	group = 'bufcheck',
	pattern = '*',
	command = 'startinsert | set winfixheight',
})

-- Start git commits in INSERT mode
autocmd('FileType', {
	group = 'bufcheck',
	pattern = { 'gitcommit', 'gitrebase' },
	command = 'startinsert',
})

-- Return to last position...
autocmd('BufReadPost', {
	group = 'bufcheck',
	pattern = '*',
	callback = function()
		if fn.line("'\"") > 0 and fn.line("'\"") <= fn.line("$") then
			fn.setpos('.', fn.getpos("'\""))
			vim.api.nvim_feedkeys('zz', 'n', true)
		end
	end,
})
