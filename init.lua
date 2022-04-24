---------------------------------------------------------------
-- 	IwanThomPhil | init.vim
---------------------------------------------------------------
require("core.utils")
require("core.mappings")
require("core.options")
require("core.plugins")
require("core.colours")
require("core.autocmds")

-- Plugins
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
require("plugin.neotree")
require("plugin.gitsigns")
require("plugin.indent-blankline")
U.source("/vim/wilder.vim")
