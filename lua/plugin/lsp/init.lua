local has_lsp, lspconfig = pcall(require, 'lspconfig')
if not has_lsp then
  return
end

--------------------------
-- LSP Run server setup --
--------------------------

-- Imports
local nvim_lsp = require('lspconfig')
local configs = require'lspconfig/configs'
local util = require 'lspconfig/util'

-- Init custom handlers
require'plugin.lsp.handlers'

-- Mappers
local mapper_tele = require'plugin.telescope.mapping'
local mapper = function(mode, key, result)
	vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua " .. result .. "<CR>", {noremap = true, silent = true})
end

local on_attach = function(client, bufnr)
	require'illuminate'.on_attach(client) 
	vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
	vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

	mapper('n', 'gD', 'vim.lsp.buf.declaration()')
	mapper('n', 'gd', 'vim.lsp.buf.definition()')
	mapper('n', 'K', 'vim.lsp.buf.hover()')
	mapper('n', 'gi', 'vim.lsp.buf.implementation()')
	mapper('n', 'gh', 'vim.lsp.buf.signature_help()')
	mapper('n', 'gl', 'vim.lsp.diagnostic.show_line_diagnostics()')
	mapper('n', '1gD', 'vim.lsp.buf.type_definition()')
	mapper('n', 'gR', 'vim.lsp.buf.rename()')
	mapper('n', 'gp', 'vim.lsp.diagnostic.goto_prev()')
	mapper('n', 'gn', 'vim.lsp.diagnostic.goto_next()')

	mapper_tele('ga', 'lsp_code_actions', nil, true)
	mapper_tele('gr', 'lsp_references', {
		layout_strategy = "vertical",
		sorting_strategy = "ascending",
		prompt_position = "top",
		ignore_filename = true,
	}, true)
	mapper_tele('<leader>wd', 'lsp_document_symbols', { ignore_filename = true }, true)
	mapper_tele('<leader>ww', 'lsp_workspace_symbols', { ignore_filename = true }, true)

	-- To consider
	-- mapper('n', '<leader>wa', 'vim.lsp.buf.add_workspace_folder()<CR>')
	-- mapper('n', '<leader>wr', 'vim.lsp.buf.remove_workspace_folder()<CR>')
	-- mapper('n', '<leader>wl', 'P(vim.lsp.buf.list_workspace_folders())')
	-- mapper('n', '<leader>q', 'vim.lsp.diagnostic.set_loclist()<CR>')

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting or client.resolved_capabilities.document_range_formatting then
		mapper('n', '<leader>r', 'vim.lsp.buf.formatting()')
	end

	-- Reset LSP and reload Buffer
	mapper('n', '<space>rr', 'vim.lsp.stop_client(vim.lsp.get_active_clients()); vim.cmd [[e]]')
end

-- Custom server configs
configs['intelephense'] = {
	default_config = {
		cmd = { "intelephense", "--stdio" };
		filetypes = { "php" };
		root_dir = function (pattern)
			local cwd  = vim.loop.cwd();
			local root = util.root_pattern("composer.json", ".git")(pattern);
			-- prefer cwd if root is a descendant
			return util.path.is_descendant(cwd, root) and cwd or root;
		end;
		init_options = { licenceKey = '/Users/iwanphillips/.config/intelephense/licence.txt' };
		settings = {
			intelephense = {
				enviroment = { phpVersion = "7.3.9"; };
				phpdoc = {
					propertyTemplate = {
						summary = "$1";
						tags = { "@var ${2:$SYMBOL_TYPE}" };
					},
					functionTemplate = {
						summary = "$SYMBOL_NAME";
						description = "${1}";
						tags = {
							"@param ${1:$SYMBOL_TYPE} $SYMBOL_NAME $2",
							"@return ${1:$SYMBOL_TYPE} $2",
							"@throws ${1:$SYMBOL_TYPE} $2",
							"@author Iwan Phillips <iwan.phillips@worthers.com>"
						};
					};
					classTemplate = {
						summary = "$1";
						tags = {
							"@package ${1:$SYMBOL_NAMESPACE}",
							"@author Iwan Phillips <iwan.phillips@worthers.com>"
						};
					};
				};
			};
		};
	};
}


-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "intelephense", "vuels", "tsserver", "rust_analyzer", "jsonls", }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

-- Highlighting
vim.api.nvim_command [[ hi def link LspReferenceText IncSearch ]]
vim.api.nvim_command [[ hi def link LspReferenceWrite IncSearch ]]
vim.api.nvim_command [[ hi def link LspReferenceRead IncSearch ]]

-- Linting/Formatting
local eslint = {
	lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
	lintStdin = true,
	lintFormats = {"%f:%l:%c: %m"},
	lintIgnoreExitCode = true,
	formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename ${INPUT}",
	formatStdin = true
}

local blade_formatter = {
	formatCommand = "blade-formatter --stdin --write",
	formatStdin = true
}

nvim_lsp.efm.setup {
	on_attach = on_attach,
	init_options = {documentFormatting = true},
	filetypes = {"javascript", "typescript", "blade"},
	root_dir = function(fname)
		return util.root_pattern(".git")(fname);
	end,
	init_options = {documentFormatting = true},
	settings = {
		rootMarkers = {".git/"},
		languages = {
			blade = {blade_formatter},
			javascript = {eslint},
			typescript = {eslint}
		}
	}
}
