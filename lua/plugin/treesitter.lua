require("nvim-treesitter.configs").setup({
	ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})

--TreeSitter based code folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

vim.o.foldtext = [[substitute(getline(v:foldstart),'\t',repeat(' ',&tabstop),'g').'···'.trim(getline(v:foldend))]]
vim.o.foldnestmax = 3
vim.o.foldminlines = 1
vim.o.foldlevelstart=1
