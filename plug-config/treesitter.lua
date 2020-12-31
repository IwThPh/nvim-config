require'nvim-treesitter'.setup{
	indent = { enable = true },
	highlight = { enable = true },
}
--TreeSitter based code folding
vim.api.nvim_command('set foldmethod=expr')
vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')

