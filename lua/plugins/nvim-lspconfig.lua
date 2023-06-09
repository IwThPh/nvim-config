return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      setup = {
        phpactor = function()
          return true
        end,
      },
      ---@type lspconfig.options
      servers = {
        bashls = {},
        cssls = {},
        dockerls = {},
        emmet_ls = {},
        eslint = {},
        graphql = {},
        html = {},
        intelephense = {
          init_options = { licenceKey = vim.fn.expand("~/.config/intelephense/licence.txt") },
          settings = {
            intelephense = {
              enviroment = { phpVersion = "8.1.*" },
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
        jsonls = {},
        rust_analyzer = {},
        sqlls = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
        tailwindcss = {},
        terraformls = {},
        volar = {
          filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
          init_options = {
            typescript = {
              serverPath = vim.fn.expand(
                "~/.local/share/nvim/lsp_servers/tsserver/node_modules/typescript/lib/tsserverlibrary.js"
              ),
            },
          },
        },
        yamlls = {},
      },
    },
  },
}
