require'nvim-treesitter'.setup{
  	ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	highlight = { 
		enable = true 
	},
}
--TreeSitter based code folding
vim.api.nvim_command('set foldmethod=expr')
vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')

