-- Return to last edit position when opening files (You want this!)
-- vim.cmd([[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]])

-- Move a line of text using ALT+[jk] or Command+[jk] on mac
-- nmap("<M-J>", "mz:m+<cr>`z")
-- nmap("<M-K>", "mz:m-2<cr>`z")
-- vmap("<M-j>", ":m'>+<cr>`<my`>mzgv`yo`z")
-- vmap("<M-k>", ":m'<-2<cr>`>my`<mzgv`yo`z")

local function nmap(key, cmd, opts)
    vim.api.nvim_set_keymap("n", key, cmd, opts)
end
local function vmap(key, cmd, opts)
    vim.api.nvim_set_keymap("v", key, cmd, opts)
end

-- n, v, i, t = mode names
local remap = { noremap = false }
nmap("˙", "<M-h>", remap)
nmap("∆", "<M-j>", remap)
nmap("˚", "<M-k>", remap)
nmap("¬", "<M-l>", remap)
vmap("˙", "<M-h>", remap)
vmap("∆", "<M-j>", remap)
vmap("˚", "<M-k>", remap)
vmap("¬", "<M-l>", remap)

local function termcodes(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local M = {}

M.general = {

	i = {
	},

	n = {
		-- save
		["<leader><leader>"] = { "<cmd> w <CR>", "﬚  save file" },

		["<leader><cr>"] = { "<cmd> noh <CR>", "  no highlight" },

		-- change current working directory to current buffer
		["<leader>cd"] = { "<cmd> cd %:p:h<cr><cmd> pwd<cr>", "🗎  change CWD" },

		-- switch between windows
		["<C-h>"] = { "<C-w>h", "  window left" },
		["<C-l>"] = { "<C-w>l", "  window right" },
		["<C-j>"] = { "<C-w>j", "  window down" },
		["<C-k>"] = { "<C-w>k", "  window up" },

		-- resize windows
		["<M-h>"] = { "<cmd> vertical resize -2<CR>", "  decrease window width" },
		["<M-l>"] = { "<cmd> vertical resize +2<CR>", "  increase window width" },
		["<M-j>"] = { "<cmd> resize -2<CR>", "  decrease window height" },
		["<M-k>"] = { "<cmd> resize +2<CR>", "  increase window height" },

		-- spell checking
		["<leader>ss"] = { ":setlocal spell!<cr>", "  toggle spell checking" },
		["<leader>sn"] = { ":setlocal spell!<cr>", "  move to next spell error" },
		["<leader>sp"] = { ":setlocal spell!<cr>", "  move to previous spell error" },
		["<leader>sa"] = { ":setlocal spell!<cr>", "  add spelling to dictionary" },

		-- splits
		["="] = { ":vsplit<cr>", "❙  vertical split" },
		["-"] = { ":split<cr>", "―  horizontal split" },
	},

	v = {
		-- indentation
		[">"] = { ">gv", "  increase indentation" },
		["<"] = { "<gv", "  decrease indentation" },
	},

	t = {
		["<C-x>"] = { termcodes "<C-\\><C-N>", "   escape terminal mode" },
		-- -- Map escape to escape sequence in terminal buffer.
		-- tmap("<Esc>", "<C-\\><C-n>")
	},
}

M.tabufline = {

	n = {
		-- new buffer
		["<S-b>"] = { "<cmd> enew <CR>", "烙 new buffer" },

		-- cycle through buffers
		["<TAB>"] = { "<cmd> Tbufnext <CR>", "  goto next buffer" }, -- BufferNext
		["<S-Tab>"] = { "<cmd> Tbufprev <CR> ", "  goto prev buffer" }, -- BufferPrevious

		-- cycle through tabs
		["<leader>tp"] = { "<cmd> tabprevious <CR>", "  goto next tab" },
		["<leader>tn"] = { "<cmd> tabnext <CR> ", "  goto prev tab" },

		-- close buffer + hide terminal buffer
		["<leader>q"] = {
			function()
				require("core.utils").close_buffer()
			end,
			"   close buffer",
		},
	},
}

M.comment = {

	-- toggle comment in both modes
	n = {
		["<leader>/"] = {
			function()
				require("Comment.api").toggle_current_linewise()
			end,

			"蘒  toggle comment",
		},
	},

	v = {
		["<leader>/"] = {
			"<ESC><cmd> lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
			"蘒  toggle comment",
		},
	},
}

M.lspconfig = {
	-- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

	n = {
		["gD"] = {
			function()
				vim.lsp.buf.declaration()
			end,
			"   lsp declaration",
		},

		["gd"] = {
			function()
				vim.lsp.buf.definition()
			end,
			"   lsp definition",
		},

		["K"] = {
			function()
				vim.lsp.buf.hover()
			end,
			"   lsp hover",
		},

		["gi"] = {
			function()
				vim.lsp.buf.implementation()
			end,
			"   lsp implementation",
		},

		["<leader>ls"] = {
			function()
				vim.lsp.buf.signature_help()
			end,
			"   lsp signature_help",
		},

		["<leader>D"] = {
			function()
				vim.lsp.buf.type_definition()
			end,
			"   lsp definition type",
		},

		["<leader>ra"] = {
			function()
			    vim.lsp.buf.rename()
				-- require("nvchad.ui.renamer").open()
			end,
			"   lsp rename",
		},

		["<leader>ca"] = {
			function()
				vim.lsp.buf.code_action()
			end,
			"   lsp code_action",
		},

		["gr"] = {
			function()
				vim.lsp.buf.references()
			end,
			"   lsp references",
		},

		["<leader>f"] = {
			function()
				vim.diagnostic.open_float()
			end,
			"   floating diagnostic",
		},

		["[d"] = {
			function()
				vim.diagnostic.goto_prev()
			end,
			"   goto prev",
		},

		["d]"] = {
			function()
				vim.diagnostic.goto_next()
			end,
			"   goto_next",
		},

		["<leader>fm"] = {
			function()
				vim.lsp.buf.format ({ async = true })
			end,
			"   lsp formatting",
		},

		["<leader>wa"] = {
			function()
				vim.lsp.buf.add_workspace_folder()
			end,
			"   add workspace folder",
		},

		["<leader>wr"] = {
			function()
				vim.lsp.buf.remove_workspace_folder()
			end,
			"   remove workspace folder",
		},

		["<leader>wl"] = {
			function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end,
			"   list workspace folders",
		},
	},
}

M.neotree = {

	n = {
		-- toggle
		["<C-n>"] = { "<cmd> NeoTreeFocusToggle <CR>", "   toggle nvimtree" },

		-- focus
		["<leader>e"] = { "<cmd> NeoTreeFocus <CR>", "   focus nvimtree" },
	},
}

M.telescope = {
	n = {
		-- find
		["<C-f>"] = { "<cmd> Telescope find_files <CR>", "  find files" },
		["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "  find files" },
		["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "  find all" },
		["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "   live grep" },
		["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "  find buffers" },
		["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "  help page" },
		["<leader>tk"] = { "<cmd> Telescope keymaps <CR>", "   show keys" },

		-- spelling
		["<leader>so"] = { "<cmd> Telescope spell_suggest <CR>", "🕮   show spelling options" },

		-- git
		["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "   git commits" },
		["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "  git status" },
		["<leader>gs"] = { "<cmd> Telescope git_branches <CR>", "  show git branches" },

		-- pick a hidden term
		["<leader>pt"] = { "<cmd> Telescope terms <CR>", "   pick hidden term" },


		-- function M.edit_neovim()
		-- 	require("telescope.builtin").find_files({
		-- 		prompt_title = "~ dotfiles ~",
		-- 		cwd = "~/.config/nvim",
		--
		-- 		layout_strategy = "horizontal",
		-- 		layout_config = {
		-- 			preview_width = 0.65,
		-- 		},
		-- 	})
		-- end

		-- function M.live_grep_string_input()
		-- 	local default = vim.api.nvim_eval([[expand('<cword>')]])
		-- 	local search = vim.ui.input({
		-- 		prompt = "Search for: ",
		-- 		default = default,
		-- 	}, function(input)
		-- 		require("telescope.builtin").grep_string({ search = input })
		-- 	end)
		--
		-- end

		-- function M.project_vendor_search()
		-- 	require("telescope.builtin").find_files({
		-- 		prompt_title = "~ vendor files ~",
		-- 		cwd = "./vendor",
		--
		-- 		layout_strategy = "horizontal",
		-- 		layout_config = {
		-- 			preview_width = 0.65,
		-- 		},
		-- 	})
		-- end

	},
}

M.nvterm = {
	t = {
		-- toggle in terminal mode
		["<A-i>"] = {
			function()
				require("nvterm.terminal").toggle "float"
			end,
			"   toggle floating term",
		},

		["<A-h>"] = {
			function()
				require("nvterm.terminal").toggle "horizontal"
			end,
			"   toggle horizontal term",
		},

		["<A-v>"] = {
			function()
				require("nvterm.terminal").toggle "vertical"
			end,
			"   toggle vertical term",
		},
	},

	n = {
		-- toggle in normal mode
		["<A-i>"] = {
			function()
				require("nvterm.terminal").toggle "float"
			end,
			"   toggle floating term",
		},

		["<A-h>"] = {
			function()
				require("nvterm.terminal").toggle "horizontal"
			end,
			"   toggle horizontal term",
		},

		["<A-v>"] = {
			function()
				require("nvterm.terminal").toggle "vertical"
			end,
			"   toggle vertical term",
		},

		-- new

		["<leader>h"] = {
			function()
				require("nvterm.terminal").new "horizontal"
			end,
			"   new horizontal term",
		},

		["<leader>v"] = {
			function()
				require("nvterm.terminal").new "vertical"
			end,
			"   new vertical term",
		},
	},
}

M.whichkey = {
	n = {
		["<leader>wK"] = {
			function()
				vim.cmd "WhichKey"
			end,
			"   which-key all keymaps",
		},
		["<leader>wk"] = {
			function()
				local input = vim.fn.input "WhichKey: "
				vim.cmd("WhichKey " .. input)
			end,
			"   which-key query lookup",
		},
	},
}

M.blankline = {
	n = {
		["<leader>bc"] = {
			function()
				local ok, start = require("indent_blankline.utils").get_current_context(
					vim.g.indent_blankline_context_patterns,
					vim.g.indent_blankline_use_treesitter_scope
				)

				if ok then
					vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
					vim.cmd [[normal! _]]
				end
			end,

			"  Jump to current_context",
		},
	},
}

return M
