local present, lspconfig = pcall(require, "lspconfig")

if not present then
	return
end

local M = {}
local utils = require "core.utils"

require "ui.lsp"

local lspconfig_util = require("lspconfig.util")
local lspconfig_configs = require("lspconfig.configs")

M.on_attach = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false

	local lsp_mappings = utils.load_config().mappings.lspconfig
	utils.load_mappings({ lsp_mappings }, { buffer = bufnr })

	-- if client.server_capabilities.signatureHelpProvider then
	--    require("nvchad.ui.signature").setup(client)
	-- end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

local volar_cmd = { "/Users/iwanphillips/.local/share/nvim/lsp_servers/volar/node_modules/.bin/vue-language-server", "--stdio" }
local volar_root_dir = lspconfig_util.root_pattern("package.json")
local ts_serverpath = "/Users/iwanphillips/.local/share/nvim/lsp_servers/tsserver/node_modules/typescript/lib/tsserverlibrary.js"


-- Custom lsp language servers
lspconfig_configs.volar_api = {
	default_config = {
		cmd = volar_cmd,
		root_dir = volar_root_dir,
		filetypes = { "vue" },
		-- If you want to use Volar's Take Over Mode (if you know, you know)
		--filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
		init_options = {
			typescript = {
				serverPath = ts_serverpath,
			},
			languageFeatures = {
				inlayHints = true, -- new in @volar/vue-language-server v0.34.8
				implementation = true, -- new in @volar/vue-language-server v0.33
				references = true,
				definition = true,
				typeDefinition = true,
				callHierarchy = true,
				hover = true,
				rename = true,
				renameFileRefactoring = true,
				signatureHelp = true,
				codeAction = true,
				workspaceSymbol = true,
				completion = {
					defaultTagNameCase = "both",
					defaultAttrNameCase = "kebabCase",
					getDocumentNameCasesRequest = false,
					getDocumentSelectionRequest = false,
				},
			},
		},
	},
}
lspconfig_configs.volar_doc = {
	default_config = {
		cmd = volar_cmd,
		root_dir = volar_root_dir,
		filetypes = { "vue" },
		-- If you want to use Volar's Take Over Mode (if you know, you know):
		--filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
		init_options = {
			typescript = {
				serverPath = ts_serverpath,
			},
			languageFeatures = {
				inlayHints = true,
				implementation = true, -- new in @volar/vue-language-server v0.33
				documentHighlight = true,
				documentLink = true,
				codeLens = { showReferencesNotification = true },
				-- not supported - https://github.com/neovim/neovim/pull/15723
				semanticTokens = false,
				diagnostics = true,
				schemaRequestService = true,
			},
		},
	},
}
lspconfig_configs.volar_html = {
	default_config = {
		cmd = volar_cmd,
		root_dir = volar_root_dir,
		filetypes = { "vue" },
		-- If you want to use Volar's Take Over Mode (if you know, you know), intentionally no 'json':
		--filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
		init_options = {
			typescript = {
				serverPath = ts_serverpath,
			},
			languageFeatures = {
				inlayHints = true,
			},
			documentFeatures = {
				selectionRange = true,
				foldingRange = true,
				linkedEditingRange = true,
				documentSymbol = true,
				-- not supported - https://github.com/neovim/neovim/pull/13654
				documentColor = false,
				documentFormatting = {
					defaultPrintWidth = 100,
				},
			},
		},
	},
}

local servers = {
	bashls = true,
	cssls = false,
	dockerls = true,
	emmet_ls = true,
	eslint = true,
	graphql = true,
	html = true,
	intelephense = {
		init_options = { licenceKey = "/Users/iwanphillips/.config/intelephense/licence.txt" },
		settings = {
			intelephense = {
				enviroment = { phpVersion = "7.4.21" },
				phpdoc = {
					propertyTemplate = {
						summary = "$1",
						tags = { "@var ${2:$SYMBOL_TYPE}" },
					},
					functionTemplate = {
						summary = "$SYMBOL_NAME",
						description = "${1}",
						tags = {
							"@param ${1:$SYMBOL_TYPE} $SYMBOL_NAME $2",
							"@return ${1:$SYMBOL_TYPE} $2",
							"@throws ${1:$SYMBOL_TYPE} $2",
						},
					},
					classTemplate = {
						summary = "$1",
						tags = {
							"@package ${1:$SYMBOL_NAMESPACE}",
						},
					},
				},
			},
		},
	},
	jsonls = true,
	rust_analyzer = true,
	sqlls = {
		cmd = { "sql-language-server", "up", "--method", "stdio" },
		settings = {
			cmd = { "sql-language-server", "up", "--method", "stdio" },
		},
	},
	sumneko_lua = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand "$VIMRUNTIME/lua"] = true,
					[vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
			telemetry = {
				enable = false,
			},
		},
	},
	tailwindcss = true,
	tsserver = {
		cmd = { "typescript-language-server", "--stdio" },
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		on_attach = M.on_attach,
	},
	-- volar = {
	-- 	settings = {
	-- 		languageFeatures = {
	-- 			-- not supported - https://github.com/neovim/neovim/pull/14122
	-- 			semanticTokens = false,
	-- 			references = true,
	-- 			definition = true,
	-- 			typeDefinition = true,
	-- 			callHierarchy = true,
	-- 			hover = true,
	-- 			rename = true,
	-- 			renameFileRefactoring = true,
	-- 			signatureHelp = true,
	-- 			codeAction = true,
	-- 			completion = {
	-- 				defaultTagNameCase = "both",
	-- 				defaultAttrNameCase = "kebabCase",
	-- 			},
	-- 			schemaRequestService = true,
	-- 			documentHighlight = true,
	-- 			documentLink = true,
	-- 			codeLens = true,
	-- 			diagnostics = true,
	-- 		},
	-- 		documentFeatures = {
	-- 			-- not supported - https://github.com/neovim/neovim/pull/13654
	-- 			documentColor = false,
	-- 			selectionRange = true,
	-- 			foldingRange = true,
	-- 			linkedEditingRange = true,
	-- 			documentSymbol = true,
	-- 			documentFormatting = {
	-- 				defaultPrintWidth = 100,
	-- 			},
	-- 		},
	-- 	},
	-- 	init_options = {
	-- 		typescript = {
	-- 			serverPath = "~/.local/share/nvim/lsp_servers/tsserver/node_modules/typescript/lib/tsserverlibrary.js",
	-- 		},
	-- 	},
	-- },
	volar_api = true,
	volar_doc = true,
	volar_html = true,
	yamlls = true,
	zk = true,
}

M.setup_server = function(server, config)
	if not config then
		return
	end

	if type(config) ~= "table" then
		config = {}
	end

	config = vim.tbl_deep_extend("force", {
		-- on_init = custom_init,
		on_attach = M.on_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = nil,
		},
	}, config)

	lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
	M.setup_server(server, config)
end

return M
