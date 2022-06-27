require("nvim-treesitter.configs").setup({
	ensure_installed = "all", -- one of "all" or a list of languages
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})

--TreeSitter based code folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lnum==1?'>1':getline(v:lnum)=~'use'?1:nvim_treesitter#foldexpr()"
vim.o.foldtext = [[substitute(getline(v:foldstart),'\t',repeat(' ',&tabstop),'g').'···'.trim(getline(v:foldend))]]
vim.o.foldnestmax = 3
vim.o.foldminlines = 1
vim.o.foldlevelstart=1
