-------------------------------------------------------------
--            .    _  _  _  /_ .//._   _  _/_              --
--           /|/|//_|/ //_// //////_/_\./_//_'|/           --
--                     /         /                         --
--  Neovim Config | Iwan Phillips <iwan@iwanphillips.dev>  --
-------------------------------------------------------------

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Source basic configs
require("config.autocmds")
require("config.keymaps")
require("config.options")

-- Install package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",

  -- Alternative files
  {
    "tpope/vim-projectionist",
    config = function()
      vim.keymap.set("n", "]r", "<cmd> A <CR>")

      vim.g.projectionist_heuristics = {
        --PHP app testing
        ["app/|tests/"] = {
          ["app/*.php"] = { alternate = "tests/Unit/{}Test.php" },
          ["tests/Unit/*Test.php"] = { alternate = "app/{}.php" },
        },

        --TODO: add rules for Laravel Models / Factories
      }
    end,
  },

  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        vim.keymap.set(
          "n",
          "<leader>hp",
          require("gitsigns").preview_hunk,
          { buffer = bufnr, desc = "Preview git hunk" }
        )

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ "n", "v" }, "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
        vim.keymap.set({ "n", "v" }, "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
      end,
    },
  },

  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim",  opts = {} },

  { import = "custom.plugins" },
}, {})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
