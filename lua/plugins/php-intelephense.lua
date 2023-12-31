return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "php" })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "intelephense")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          init_options = { licenceKey = vim.fn.expand("~/.config/intelephense/licence.txt") },
          settings = {
            ---@diagnostic disable-next-line: missing-fields
            intelephense = {
              licenceKey = vim.fn.expand("~/.config/intelephense/licence.txt") .. "",
              enviroment = { phpVersion = "8.1.*" },
            },
          },
        },
      },
    },
  },
}
