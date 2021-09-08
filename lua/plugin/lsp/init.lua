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

-- Additional LSP Plugins
require'plugin.lsp.lspkind'
require'plugin.lsp.trouble'

local on_attach = require'plugin.lsp.on-attach'

-- Custom server configs
configs['php'] = {
	default_config = {
		cmd = { "intelephense", "--stdio" };
		filetypes = { "php", "blade.php" };
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
						};
					};
					classTemplate = {
						summary = "$1";
						tags = {
							"@package ${1:$SYMBOL_NAMESPACE}",
						};
					};
				};
				format = {
					braces = {
						"allman"
					};
				};
			};
		};
	};
}

configs['vue'] = {
	default_config = {
		cmd = { "vls" };
		filetypes = {"vue"};
		root_dir = util.root_pattern("package.json");
		init_options = {
			config = {
				vetur = {
					useWorkspaceDependencies = true;
					validation = {
						template = true,
						script = true,
						style = true,
						templateProps = true,
						interpolation = true,
					};
					experimental = {
                    	templateInterpolationService = true
                	},
					completion = {
						autoImport = true;
						useScaffoldSnippets = true;
						tagCasing = "kebab";
					};
					format = {
						defaultFormatter = {
							js = "none";
							ts = "none";
						};
						defaultFormatterOptions = {
							tabSize = 4;
							useTabs = true;
						};
						scriptInitialIndent = false;
						styleInitialIndent = false;
					}
				};
				css = {};
				html = {
					suggest = {};
				};
				javascript = {
					format = {};
				};
				typescript = {
					format = {};
				};
				emmet = {};
				stylusSupremacy = {};
			};
		};
	};
};

-- Configure lua language server for neovim development
local lua_settings = {
  Lua = {
    runtime = {
      -- LuaJIT in the case of Neovim
      version = 'LuaJIT',
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = {'vim'},
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      },
    },
  }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

require'lspinstall'.setup() -- important
local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
	local config = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	-- language specific config
	if server == "lua" then
		config.settings = lua_settings
	end

	if server == "efm" then
		config = require'plugin.lsp.format'
	end

	require'lspconfig'[server].setup(config)
end

nvim_lsp['sqlls'].setup {
	on_attach = on_attach,
	cmd = {"sql-language-server", "up", "--method", "stdio"};
	settings = {
		cmd = {"sql-language-server", "up", "--method", "stdio"};
	},
}

-- Highlighting
vim.api.nvim_command [[ hi def link LspReferenceText IncSearch ]]
vim.api.nvim_command [[ hi def link LspReferenceWrite IncSearch ]]
vim.api.nvim_command [[ hi def link LspReferenceRead IncSearch ]]
