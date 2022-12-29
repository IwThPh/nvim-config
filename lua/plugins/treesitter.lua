local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
	return
end

local options = {
	ensure_installed = "all",
	ignore_install = { "phpdoc", "tree-sitter-phpdoc" }, -- List of parsers to ignore installing
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	indent = {
		enable = true,
	},
}

local o = vim.o

o.foldmethod = "expr"
o.foldexpr = "v:lnum==1?'>1':getline(v:lnum)=~'use'?1:nvim_treesitter#foldexpr()"
o.foldtext = [[substitute(getline(v:foldstart),'\t',repeat(' ',&tabstop),'g').'···'.trim(getline(v:foldend))]]
o.foldnestmax = 3
o.foldminlines = 1
o.foldlevelstart = 1

treesitter.setup(options)
