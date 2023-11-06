return {
  "tpope/vim-projectionist",
  config = function()
    vim.keymap.set("n", "]r", "<cmd> A <CR>")

    vim.g.projectionist_heuristics = {
      ["app/Models/|database/factories/|app/Nova"] = {
        ["app/Models/*.php"] = { alternate = "database/factories/{}Factory.php" },
        ["database/factories/*Factory.php"] = { alternate = "app/Models/{}.php" },
        ["app/Nova/*.php"] = { alternate = "app/Models/{}.php" },
      },
      ["app/|tests/"] = {
        ["app/*.php"] = { alternate = "tests/Unit/{}Test.php" },
        ["tests/Unit/*Test.php"] = { alternate = "app/{}.php" },
      },
      ["src/|tests/"] = {
        ["src/*.ts"] = { alternate = "tests/Unit/{}.test.ts" },
        ["tests/Unit/*.test.ts"] = { alternate = "src/{}.ts" },
      },
    }
  end,
}
