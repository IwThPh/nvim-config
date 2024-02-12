local Util = require("custom.util")
return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  branch = "0.1.x",
  version = false, -- telescope did only one release, so use HEAD for now

  dependencies = {
    "nvim-lua/plenary.nvim",
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = "make",
      cond = function() return vim.fn.executable("make") == 1 end,
    },
  },

  keys = {
    {
      "<leader>/",
      function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        Util.telescope("current_buffer_fuzzy_find", (require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        })))
      end,
      { desc = "[/] Fuzzily search in current buffer" },
    },
    { "<leader>gf", Util.telescope("git_files"),   desc = "Search [G]it [F]iles" },
    { "<leader>sf", Util.telescope("find_files"),  desc = "[S]earch [F]iles" },
    { "<leader>sh", Util.telescope("help_tags"),   desc = "[S]earch [H]elp" },
    { "<leader>sg", Util.telescope("live_grep"),   desc = "[S]earch by [G]rep" },
    { "<leader>sd", Util.telescope("diagnostics"), desc = "[S]earch [D]iagnostics" },
    { "<leader>sr", Util.telescope("resume"),      desc = "[S]earch [R]resume" },
    {
      "<leader><space>",
      Util.telescope("files"),
      desc = "Find Files (root dir)",
    },

    -- find
    { "<leader>fr", Util.telescope("oldfiles"),                                        desc = "[F]ind [r]ecently opened files" },
    { "<leader>fb", Util.telescope("buffers"),                                         desc = "[F]ind [B]uffers" },
    { "<leader>ff", Util.telescope("files"),                                           desc = "[F]ind [F]iles (root dir)" },
    { "<leader>fF", Util.telescope("files", { cwd = false }),                          desc = "[F]ind [F]iles (cwd)" },

    -- git
    { "<leader>gc", Util.telescope("git_commits"),                                     desc = "[G]it [C]ommits" },
    { "<leader>gs", Util.telescope("git_status"),                                      desc = "[G]it [S]tatus" },

    -- search
    { '<leader>s"', "<cmd>Telescope registers<cr>",                                    desc = "Registers" },
    { "<leader>sC", "<cmd>Telescope commands<cr>",                                     desc = "Commands" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>",                                      desc = "Key Maps" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>",                                    desc = "Man Pages" },
    { "<leader>sm", "<cmd>Telescope marks<cr>",                                        desc = "Jump to Mark" },
    { "<leader>so", "<cmd>Telescope vim_options<cr>",                                  desc = "Options" },
    { "<leader>sw", Util.telescope("grep_string", { word_match = "-w" }),              desc = "Word (root dir)" },
    { "<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
    {
      "<leader>sw",
      Util.telescope("grep_string"),
      mode = "v",
      desc = "Selection (root dir)",
    },
    {
      "<leader>sW",
      Util.telescope("grep_string", { cwd = false }),
      mode = "v",
      desc = "Selection (cwd)",
    },
    {
      "<leader>uC",
      Util.telescope("colorscheme", { enable_preview = true }),
      desc = "Colorscheme with preview",
    },

    {
      "<leader>ss",
      Util.telescope("lsp_document_symbols", {
        symbols = {
          "Class",
          "Function",
          "Method",
          "Constructor",
          "Interface",
          "Module",
          "Struct",
          "Trait",
          "Field",
          "Property",
        },
      }),
      desc = "Goto Symbol",
    },
    {
      "<leader>sS",
      Util.telescope("lsp_dynamic_workspace_symbols", {
        symbols = {
          "Class",
          "Function",
          "Method",
          "Constructor",
          "Interface",
          "Module",
          "Struct",
          "Trait",
          "Field",
          "Property",
        },
      }),
      desc = "Goto Symbol (Workspace)",
    },
  },
  opts = function()
    require("telescope").setup({
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        mappings = {
          n = {
            ["<C-c>"] = function(...) return require("telescope.actions").close(...) end,
            ["q"] = function(...) return require("telescope.actions").close(...) end,
          },
        },
      },
    })
    -- Enable telescope fzf native, if installed
    pcall(require("telescope").load_extension, "fzf")
  end,
}
