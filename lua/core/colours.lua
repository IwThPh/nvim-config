-- Colours, Themes and Fonts
-- vim.g.material_style = 'palenight'
-- vim.g.material_italic_comments = true
-- vim.g.material_italic_keywords = true
-- vim.g.material_italic_functions = true
-- vim.g.material_italic_variables = false
-- vim.g.material_contrast = true
-- vim.g.material_borders = true

-- require'material'.set()

-- vim.g.tokyonight_style = "storm"
-- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer", "NvimTree", "Outline" }
-- vim.cmd([[colorscheme tokyonight]])

-- -- This function set the configuration of nightfox. If a value is not passed in the setup function
-- -- it will be taken from the default configuration above
local nightfox = require("nightfox")
nightfox.setup({
	options = {
		transparent = false,
		terminal_color = true,
		styles = {
			comments = "italic", -- change style of comments to be italic
			keywords = "bold", -- change style of keywords to be bold
			functions = "italic,bold", -- styles can be a comma separated list
		},
		inverse = {
			-- match_paren = true, -- Enable/Disable inverse highlighting for match parens
			-- visual = true, -- Enable/Disable inverse highlighting for visual selection
			-- search = true, -- Enable/Disable inverse highlights for search highlights
		},
	},
})

-- -- Load the configuration set above and apply the colorscheme
vim.cmd([[colorscheme terafox]])

-- vim.cmd([[colorscheme enfocado]])

-- Status line
require("lualine").setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff" },
		lualine_c = {
			{
				"filename",
				file_status = true, -- displays file status (readonly status, modified status)
				path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
				shorting_target = 40, -- Shortens path to leave 40 space in the window
			},
		},
		lualine_x = { { "diagnostics", sources = { "nvim_diagnostic" } }, "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {
			{
				"filename",
				file_status = true, -- displays file status (readonly status, modified status)
				path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
				shorting_target = 40, -- Shortens path to leave 40 space in the window
			},
		},
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {
		"nvim-tree",
		"symbols-outline",
	},
})
