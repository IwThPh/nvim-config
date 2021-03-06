local actions = require('telescope.actions')

require('telescope').setup{
	defaults = {
		mappings = {
			i = {
				["<C-n>"]  = actions.move_selection_next,
				["<C-p>"]  = actions.move_selection_previous,
				["<C-j>"]  = actions.move_selection_next,
				["<C-k>"]  = actions.move_selection_previous,
				["<C-u>"]  = actions.preview_scrolling_up,
				["<C-d>"]  = actions.preview_scrolling_down,
			},
		},
		vimgrep_arguments = {
		  'rg',
		  '--color=never',
		  '--no-heading',
		  '--with-filename',
		  '--line-number',
		  '--column',
		  '--smart-case'
		},
		prompt_position = "top",
		prompt_prefix = "> ",
		selection_caret = "> ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "flex",
		layout_defaults = {
		  horizontal = { mirror = false, },
		  vertical = { mirror = false, },
		},
		file_sorter =  require'telescope.sorters'.get_fuzzy_file,
		file_ignore_patterns = {},
		generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
		shorten_path = true,
		winblend = 0,
		width = 0.65,
		preview_cutoff = 120,
		results_height = 1,
		results_width = 0.8,
		border = {},
		borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
		color_deicons = true,
		use_less = true,
		set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
		file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
		grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
		qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
	}
}

local function set_keymap(...) vim.api.nvim_set_keymap(...) end

-- Mappings.
local opts = { noremap=true, silent=true }
set_keymap('n', '<C-f>', 		[[<cmd>lua require('telescope.builtin').find_files()<CR>]], opts)
set_keymap('n', '<C-g>', 		[[<cmd>lua require('telescope.builtin').git_status()<CR>]], opts)
set_keymap('n', '<Leader>co', 	[[<cmd>lua require('telescope.builtin').git_branches()<CR>]], opts)
set_keymap('n', '<Leader>b', 	[[<cmd>lua require('telescope.builtin').buffers()<CR>]], opts)
set_keymap('n', '<Leader>g', 	[[<cmd>lua require('telescope.builtin').live_grep()<CR>]], opts)
set_keymap('n', '<Leader>h', 	[[<cmd>lua require('telescope.builtin').help_tags()<CR>]], opts)


-- Highlight groups.
vim.api.nvim_command [[ hi def link TelescopeSelection vimWarn ]]
vim.api.nvim_command [[ hi def link TelescopeSelectionCaret Keyword ]]
vim.api.nvim_command [[ hi def link TelescopeMultiSelection Normal ]]
vim.api.nvim_command [[ hi def link TelescopeNormal TelescopeNormal ]]
vim.api.nvim_command [[ hi def link TelescopeBorder CursorLineNr ]]
vim.api.nvim_command [[ hi def link TelescopePromptBorder Todo ]]
vim.api.nvim_command [[ hi def link TelescopeResultsBorder Normal ]]
vim.api.nvim_command [[ hi def link TelescopePreviewBorder Normal ]]
vim.api.nvim_command [[ hi def link TelescopeMatching IncSearch ]]
vim.api.nvim_command [[ hi def link TelescopePromptPrefix Keyword ]]
