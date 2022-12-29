local M = {
"lukas-reineke/indent-blankline.nvim",
	name = "blankline"
}

function M.config()
   require("indent_blankline").setup({
      indentLine_enabled = 1,
      char = "▏",
      filetype_exclude = {
         "help",
         "terminal",
         "alpha",
         "packer",
         "lspinfo",
         "TelescopePrompt",
         "TelescopeResults",
         "lsp-installer",
         "",
      },
      buftype_exclude = { "terminal" },
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
      show_current_context = true,
      show_current_context_start = true,
   })
end

return M
