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
      inlay_hints = {
        enabled = false,
      },
      ---@type lspconfig.options
      ---@diagnostic disable-next-line: missing-fields
      servers = {
        dockerls = {},
        ---@diagnostic disable-next-line: missing-fields
        eslint = {},

        volar = {
          settings = {
            typescript = {
              tsdk = vim.fn.expand(
                "~/.local/share/nvim/lsp_servers/tsserver/node_modules/typescript/lib/tsserverlibrary.js"
              ) .. "",
            },
            ---@diagnostic disable-next-line: missing-fields
            vue = {},
            ---@diagnostic disable-next-line: missing-fields
            volar = {},
            ["vue-semantic-server"] = { trace = { server = "off" } },
            ["vue-syntactic-server"] = { trace = { server = "off" } },
          },
        },
        ---@diagnostic disable-next-line: missing-fields
        yamlls = {},
      },
    },
  },
}
