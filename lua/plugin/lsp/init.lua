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
