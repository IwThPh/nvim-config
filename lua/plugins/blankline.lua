local M = {
"lukas-reineke/indent-blankline.nvim",
	name = "blankline"
}

function M.config()
   require("ui.theme").load_highlight("blankline")
   require("indent_blankline").setup({
      indentLine_enabled = 1,
      char = "▏",
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
		    space_char_blankline = " ",

      buftype_exclude = { "terminal" },
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
      show_current_context = true,
      show_current_context_start = true,
   })
end

return M
