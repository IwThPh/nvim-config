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
})

vim.cmd [[ 
augroup IndentBlanklineContextAutogroup
	autocmd!
	autocmd CursorMoved * IndentBlanklineRefresh
augroup END 
]]
