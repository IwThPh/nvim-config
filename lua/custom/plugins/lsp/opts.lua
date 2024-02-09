return {
  -- options for vim.diagnostic.config()
  diagnostics = {
    underline = true,
    update_in_insert = false,
    virtual_text = {
      spacing = 4,
      source = "if_many",
      prefix = " ●",
      -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
      -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
      -- prefix = "icons",
    },
    severity_sort = true,
  },
  -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
  -- Be aware that you also will need to properly configure your LSP server to
  -- provide the inlay hints.
  inlay_hints = {
    enabled = false,
  },
  -- add any global capabilities here
  capabilities = {},
  -- Automatically format on save
  autoformat = true,
  -- Enable this to show formatters used in a notification
  -- Useful for debugging formatter issues
  format_notify = false,
  -- options for vim.lsp.buf.format
  -- `bufnr` and `filter` is handled by the LazyVim formatter,
  -- but can be also overridden when specified
  format = {
    formatting_options = nil,
    timeout_ms = nil,
  },
  -- LSP Server Settings
  ---@type lspconfig.options
  servers = {
    rust_analyzer = {},
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
      filetypes = { "typescript", "javiscript", "javascriptreact", "typescriptreact", "vue", "json" },
      init_options = {
        typescript = {
          serverPath = vim.fn.expand(
            "~/.local/share/nvim/lsp_servers/tsserver/node_modules/typescript/lib/tsserverlibrary.js"
          ),
        },
      },
    },
    tsserver = {},
    html = { filetypes = { "html", "twig", "hbs" } },
    jsonls = {},
    lua_ls = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  },
  -- you can do any additional lsp server setup here
  -- return true if you don't want this server to be setup with lspconfig
  ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
  setup = {},
}
