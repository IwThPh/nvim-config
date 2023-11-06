return {
  "mfussenegger/nvim-lint",
  opts = function(_, opts)
    opts.linters_by_ft = vim.tbl_extend("force", opts.linters_by_ft, {
      -- php = { "phpstan" },
      -- ["*"] = { "codespell" },
    })
  end,
}
