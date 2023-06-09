return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      vim.list_extend(opts.sources, {
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.sqlformat,
        nls.builtins.formatting.eslint_d,
        nls.builtins.formatting.terraform_fmt,
        -- nls.builtins.formatting.prettierd,
        nls.builtins.formatting.phpcsfixer,
      })
    end,
  },
}
