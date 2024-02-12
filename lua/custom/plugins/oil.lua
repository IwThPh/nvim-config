return {
  'stevearc/oil.nvim',
  opts = {
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true
    },

    float = {
      padding = 2,
      border = "solid", -- solid or none
      win_options = {
        winblend = 5,    -- transparency
      },
    },

    preview = {
      border = "solid", -- solid or none
      win_options = {
        winblend = 0,
      },
    },

    progress = {
      border = "solid", -- solid or none
      win_options = {
        winblend = 0,
      },
    },

    use_default_keymaps = false,
    keymaps = {
      ["<CR>"] = "actions.select",
      ["="] = "actions.select_vsplit",
      ["<C-c>"] = "actions.close",
      ["q"] = "actions.close",
      ["-"] = "actions.parent",
      ["<BS>"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["."] = "actions.cd",
      ["~"] = "actions.tcd",
      ["g?"] = "actions.show_help",
      ["gy"] = "actions.copy_entry_path",
      ["gq"] = "actions.add_to_qflist",
      ["gl"] = "actions.add_to_loclist",
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
    },
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function(_, opts)
    local oil = require("oil")
    oil.setup(opts)

    -- keymaps
    vim.keymap.set("n", "-", oil.open_float, { desc = "Open parent directory" })
  end
}
