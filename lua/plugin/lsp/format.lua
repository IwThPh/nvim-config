-- Document Formatting via EFM.
-- Formatter/Linter Setup
local eslint = {
	lintCommand = "eslint_d -f unix --stdin --stdin-filename=${INPUT}",
	lintIgnoreExitCode = true,
	lintStdin = true,
	lintFormats = {"%f:%l:%c: %m"},
	formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
	formatStdin = true
}

local blade_formatter = {
	formatCommand = "blade-formatter --stdin --write",
	formatStdin = true
}

local prettier = {
	formatCommand = "prettier --stdin-filepath ${INPUT}",
	formatStdin = true
}

-- Language setup
local languages = {
	typescript = { prettier, eslint },
	javascript = { prettier, eslint },
	typescriptreact = { prettier, eslint },
	javascriptreact = { prettier, eslint },
	vue = { prettier, eslint },
	yaml = { prettier },
	json = { prettier },
	html = { prettier },
	scss = { prettier },
	css = { prettier },
	markdown = { prettier },
	blade = { blade_formatter },
}

-- Return client config
local util = require 'lspconfig/util'
local on_attach = require 'plugin.lsp.on-attach'
local formatter = {
	root_dir = function(fname)
		return util.root_pattern(".git")(fname);
	end,
	filetypes = vim.tbl_keys(languages),
	init_options = { documentFormatting = true, codeAction = true },
	settings = { languages = languages, log_level = 1, log_file = '~/efm.log' },
	on_attach = on_attach
}

return formatter
