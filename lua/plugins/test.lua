return {
  { "olimorris/neotest-phpunit" },
  {
    "nvim-neotest/neotest-vim-test",

    dependancies = {
      {
        "vim-test/vim-test",
        opts = {
          ["test#strategy"] = "neovim",
          ["test#php#runner"] = "phpunit",
          ["test#php#phpunit#executable"] = vim.fn.stdpath("config") .. "/lua/plugins/run-phpunit.sh",
        },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        -- ["neotest-phpunit"] = {
        --   phpunit_cmd = function()
        --     return vim.fn.stdpath("config") .. "/lua/plugins/run-phpunit.sh"
        --   end,
        -- },
        ["neotest-vim-test"] = {
          allow_filetypes = { "php" },
        },
      },
    },
  },
}
