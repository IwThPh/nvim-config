local M = {
	"EdenEast/nightfox.nvim"
}

function M.config()
	require("nightfox").setup({
		options = {
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
				barbar = true,
				cmp = true,
				diagnostic = true,
				fidget = true,
				gitsigns = true,
				lsp_trouble = true,
				modes = true,
				native_lsp = true,
				neogit = true,
				neotree = true,
				notify = true,
				telescope = true,
				treesitter = true,
				whichkey = true,
			},
		},
	})
end

return M
