local M = {
    "lukas-reineke/indent-blankline.nvim",
	name = "blankline"
}

function M.config()
   require("ui.theme").load_highlight("blankline")
   require("indent_blankline").setup({
      char = "",
      filetype_exclude = {
         "lazy",
         "help",
         "terminal",
         "lspinfo",
         "TelescopePrompt",
         "TelescopeResults",
         "lsp-installer",
         "",
      },
      buftype_exclude = { "terminal" },
	  space_char_blankline = " ",
      show_trailing_blankline_indent = true,
      show_first_indent_level = true,
      show_current_context = true,
      show_current_context_start = true,
   })
end

return M
