---------------------------------------------------------------
-- 	IwanThomPhil | init.vim
---------------------------------------------------------------
require("core.utils")
require("core.mappings")
require("core.options")
require("core.plugins")
require("core.colours")

-- Plugins
if vim.g.vscode then
	U.source("/vscode/settings.vim")
else
	require("plugin.colorizer")
	require("plugin.completion")
	require("plugin.lsp")
	require("plugin.barbar")
	require("plugin.session")
	require("plugin.truezen")
	require("plugin.telescope")
	require("plugin.telescope.mapping")
	require("plugin.test")
	require("plugin.dap")
	require("plugin.treesitter")
	require("plugin.nvimtree")
	require("plugin.gitsigns")
	require("plugin.indent-blankline")
	require("plugin.outline")
	U.source("/vim/wilder.vim")
end

-- Work around for netrw | barbar bug
vim.g.netrw_bufsettings = "noma nomod nonu nowrap ro buflisted"
