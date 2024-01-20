return {
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    opts = {
      transparent = false,
      terminal_color = true,
      styles = {
        comments = "italic", -- change style of comments to be italic
        keywords = "bold", -- change style of keywords to be bold
        functions = "italic,bold", -- styles can be a comma separated list
      },
      inverse = {
        match_paren = true, -- Enable/Disable inverse highlighting for match parens
        visual = true, -- Enable/Disable inverse highlighting for visual selection
        search = true, -- Enable/Disable inverse highlights for search highlights
      },
      modules = {
        aerial = true,
        barbar = true,
        cmp = true,
        coc = true,
        ["dap-ui"] = true,
        dashboard = true,
        diagnostic = true,
        fern = true,
        fidget = true,
        gitgutter = true,
        gitsigns = true,
        glyph_palette = true,
        hop = true,
        illuminate = true,
        lightspeed = true,
        lsp_saga = true,
        lsp_trouble = true,
        mini = true,
        modes = true,
        native_lsp = true,
        neogit = true,
        neotest = true,
        neotree = true,
        notify = true,
        nvimtree = true,
        symbol_outline = true,
        telescope = true,
        treesitter = true,
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "terafox",
    },
  },
}
