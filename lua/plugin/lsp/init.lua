--------------------------
-- LSP Run server setup --
--------------------------

-- Imports
local nvim_lsp = require("lspconfig")
local configs = require("lspconfig/configs")
local util = require("lspconfig/util")

-- Init custom handlers
require("plugin.lsp.handlers")

-- Additional LSP Plugins
require("plugin.lsp.lspkind")
require("plugin.lsp.trouble")

local on_attach = require("plugin.lsp.on-attach")

-- Custom server configs
local lua_settings = {
	Lua = {
		runtime = {
			-- LuaJIT in the case of Neovim
			version = "LuaJIT",
			path = vim.split(package.path, ";"),
		},
		diagnostics = {
			-- Get the language server to recognize the `vim` global
			globals = { "vim" },
		},
		workspace = {
			-- Make the server aware of Neovim runtime files
			library = {
				[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
			},
		},
	},
}

local intelephense_settings = {
	default_config = {
		cmd = { "intelephense", "--stdio" },
		filetypes = { "php", "blade.php" },
		root_dir = function(pattern)
			local cwd = vim.loop.cwd()
			local root = util.root_pattern("composer.json", ".git")(pattern)
			-- prefer cwd if root is a descendant
			return util.path.is_descendant(cwd, root) and cwd or root
		end,
		init_options = { licenceKey = "/Users/iwanphillips/.config/intelephense/licence.txt" },
		settings = {
			intelephense = {
				enviroment = { phpVersion = "7.3.9" },
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
				format = {
					braces = {
						"allman",
					},
				},
			},
		},
	},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
	}

	-- language specific config
	if server.name == "lua" then
		opts.settings = lua_settings
	end

	if server.name == "intelephense" then
		opts.settings = intelephense_settings
	end

	if server.name == "intelephense" then
		opts.settings = intelephense_settings
	end

    if server.name == "sqlls" then
		opts.cmd = { "sql-language-server", "up", "--method", "stdio" }
		opts.settings = {
			cmd = { "sql-language-server", "up", "--method", "stdio" },
		}
    end

    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

-- Null ls
-- Initialise null language server
require("plugin.lsp.null-ls")
nvim_lsp["null-ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Highlighting
vim.api.nvim_command([[ hi def link LspReferenceText IncSearch ]])
vim.api.nvim_command([[ hi def link LspReferenceWrite IncSearch ]])
vim.api.nvim_command([[ hi def link LspReferenceRead IncSearch ]])

-- -- VOLAR MULTISERVER CONFIG https://github.com/johnsoncodehk/volar/discussions/606
-- local volar_cmd = { "volar-server", "--stdio" }
-- local volar_root_dir = util.root_pattern("package.json")

-- configs.volar_api = {
-- 	default_config = {
-- 		cmd = volar_cmd,
-- 		root_dir = volar_root_dir,
-- 		-- If you want to use Volar's Take Over Mode (if you know, you know)
-- 		filetypes = {  "vue", "json" },
-- 		init_options = {
-- 			typescript = {
-- 				serverPath = "../../../typescript/lib/tsserverlibrary.js",
-- 			},
-- 			languageFeatures = {
-- 				references = true,
-- 				definition = true,
-- 				typeDefinition = true,
-- 				callHierarchy = true,
-- 				hover = true,
-- 				rename = true,
-- 				renameFileRefactoring = true,
-- 				signatureHelp = true,
-- 				codeAction = true,
-- 				workspaceSymbol = true,
-- 				completion = {
-- 					defaultTagNameCase = "both",
-- 					defaultAttrNameCase = "kebabCase",
-- 					getDocumentNameCasesRequest = false,
-- 					getDocumentSelectionRequest = false,
-- 				},
-- 			},
-- 		},
-- 	},
-- }
-- nvim_lsp.volar_api.setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- 	flags = {
-- 		debounce_text_changes = 150,
-- 	},
-- })

-- configs.volar_doc = {
-- 	default_config = {
-- 		cmd = volar_cmd,
-- 		root_dir = volar_root_dir,
-- 		filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
-- 		init_options = {
-- 			typescript = {
-- 				serverPath = "../../../typescript/lib/tsserverlibrary.js",
-- 			},
-- 			languageFeatures = {
-- 				documentHighlight = true,
-- 				documentLink = true,
-- 				codeLens = { showReferencesNotification = true },
-- 				-- not supported - https://github.com/neovim/neovim/pull/14122
-- 				semanticTokens = false,
-- 				diagnostics = true,
-- 				schemaRequestService = true,
-- 			},
-- 		},
-- 	},
-- }
-- nvim_lsp.volar_doc.setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- 	flags = {
-- 		debounce_text_changes = 150,
-- 	},
-- })

-- configs.volar_html = {
-- 	default_config = {
-- 		cmd = volar_cmd,
-- 		root_dir = volar_root_dir,
-- 		filetypes = { "vue" },
-- 		init_options = {
-- 			typescript = {
-- 				serverPath = "../../../typescript/lib/tsserverlibrary.js",
-- 			},
-- 			documentFeatures = {
-- 				selectionRange = true,
-- 				foldingRange = true,
-- 				linkedEditingRange = true,
-- 				documentSymbol = true,
-- 				-- not supported - https://github.com/neovim/neovim/pull/13654
-- 				documentColor = false,
-- 				documentFormatting = {
-- 					defaultPrintWidth = 100,
-- 				},
-- 			},
-- 		},
-- 	},
-- }
-- nvim_lsp.volar_html.setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- 	flags = {
-- 		debounce_text_changes = 150,
-- 	},
-- })
