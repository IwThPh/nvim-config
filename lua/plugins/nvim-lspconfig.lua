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
        html = {},
        cssls = {},
        dockerls = {},
        emmet_ls = {},
        graphql = {},
        intelephense = {
          init_options = { licenceKey = vim.fn.expand("~/.config/intelephense/licence.txt") },
          settings = {
            intelephense = {
              enviroment = { phpVersion = "8.1.*" },
            },
          },
        },
        sqlls = {},
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
