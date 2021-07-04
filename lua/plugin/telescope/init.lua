if not pcall(require, 'telescope') then
  return
end

local should_reload = true
local reloader = function()
  if should_reload then
    RELOAD('plenary')
    RELOAD('popup')
    RELOAD('telescope')
  end
end

reloader()

local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
local themes = require('telescope.themes')

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
		prompt_prefix = "> ",
		selection_caret = "> ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		scroll_strategy = nil,
		layout_strategy = "flex",
		layout_config = {
			width = 0.95,
			height = 0.85,
			prompt_position = "top",
			horizontal = { 
				mirror = false,
				preview_width = function(_, cols, _)
					if cols > 200 then
						return math.floor(cols * 0.4)
					else
						return math.floor(cols * 0.6)
					end
				end,
			},
			vertical = {
				mirror = false,
				width = 0.9,
				height = 0.95,
				preview_height = 0.5,
			},
		},
		file_sorter =  require'telescope.sorters'.get_fuzzy_file,
		file_ignore_patterns = {},
		generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
		shorten_path = true,
		winblend = 0,
		border = {},
		borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
		color_deicons = true,
		use_less = true,
		set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,

		file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
		grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
		qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
	},
	extensions = {
        fzf_writer = {
            minimum_grep_characters = 2,
            minimum_files_characters = 2,
            use_highlighter = true,
        }
    }
}

require('telescope').load_extension('fzf_writer')
require('telescope').load_extension('dap')

-- Highlight groups.
local nvim_cmd = vim.api.nvim_command
nvim_cmd [[ hi def link TelescopeSelection vimWarn ]]
nvim_cmd [[ hi def link TelescopeSelectionCaret Keyword ]]
nvim_cmd [[ hi def link TelescopeMultiSelection Normal ]]
nvim_cmd [[ hi def link TelescopeNormal TelescopeNormal ]]
nvim_cmd [[ hi def link TelescopeBorder CursorLineNr ]]
nvim_cmd [[ hi def link TelescopePromptBorder Todo ]]
nvim_cmd [[ hi def link TelescopeResultsBorder Normal ]]
nvim_cmd [[ hi def link TelescopePreviewBorder Normal ]]
nvim_cmd [[ hi def link TelescopeMatching IncSearch ]]
nvim_cmd [[ hi def link TelescopePromptPrefix Keyword ]]

-- Initially taken from TJDevris' dots. github.com/tjdevries/config_manager
local M = {}

function M.edit_neovim()
  require('telescope.builtin').find_files {
    prompt_title = "~ dotfiles ~",
    shorten_path = false,
    cwd = "~/.config/nvim",

    layout_strategy = 'horizontal',
    layout_config = {
      preview_width = 0.65,
    },
  }
end

function M.git_files()
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }

  require('telescope.builtin').git_files(opts)
end

function M.buffer_git_files()
  require('telescope.builtin').git_files(themes.get_dropdown {
    cwd = vim.fn.expand("%:p:h"),
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  })
end

function M.lsp_code_actions()
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }

  require('telescope.builtin').lsp_code_actions(opts)
end

function M.live_grep()
 require('telescope').extensions.fzf_writer.staged_grep {
   shorten_path = true,
   previewer = false,
   fzf_separator = "|>",
 }
end

function M.project_search()
  require('telescope.builtin').find_files {
    layout_strategy = 'horizontal',
    layout_config = {
      preview_width = 0.5,
    },
    cwd = require('lspconfig.util').root_pattern(".git")(vim.fn.expand("%:p")),
  }
end

function M.buffers()
  require('telescope.builtin').buffers {
    shorten_path = false,
  }
end

function M.help_tags()
  require('telescope.builtin').help_tags {
    show_version = true,
  }
end

function M.dap_frames()
 require('telescope').extensions.dap.frames { }
end

function M.dap_list()
 require('telescope').extensions.dap.list_breakpoints { }
end

return setmetatable({}, {
  __index = function(_, k)
    reloader()

    if M[k] then
      return M[k]
    else
      return require('telescope.builtin')[k]
    end
  end
})
