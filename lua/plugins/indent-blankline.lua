vim.opt.list = true
vim.opt.listchars:append("space:⋅")

vim.g.indent_blankline_buftype_exclude = {
	"terminal",
}
vim.g.indent_blankline_filetype_exclude = {
	"help",
	"NvimTree",
	"dashboard",
	"packer",
	"TelescopePrompt",
	"Outline",
}

require("indent_blankline").setup({
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
})

local indent_group = vim.api.nvim_create_augroup('IndentBlanklineContextAutogroup', { clear = true })
vim.api.nvim_create_autocmd('CursorMoved', {
	group = indent_group,
	pattern = '*',
	command = 'IndentBlanklineRefresh',
})
