require("gitsigns").setup({
	signs = {
		add = { hl = "GitGutterAdd", text = "▋" },
		change = { hl = "GitGutterChange", text = "▋" },
		delete = { hl = "GitGutterDelete", text = "▋" },
		topdelete = { hl = "GitGutterDelete", text = "▔" },
		changedelete = { hl = "GitGutterChange", text = "▞" },
	},
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		interval = 1000,
		follow_files = true,
	},
	attach_to_untracked = true,
	current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
	},
	current_line_blame_formatter = " <summary> | <author> - <author_time:%d/%m/%y>",
	keymaps = {
		-- Default keymap options
		noremap = true,
		buffer = true,

		["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
		["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },

		["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
		["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
		["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
		["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
		["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line()<CR>',

		-- Text objects
		["o ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
		["x ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
	},
	sign_priority = 1,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000,
	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	yadm = {
		enable = false,
	},
})
