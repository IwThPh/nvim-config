local function nvmapNoRemap(key, cmd)
	local opts = { noremap = false }
	vim.api.nvim_set_keymap("n", key, cmd, opts)
	vim.api.nvim_set_keymap("v", key, cmd, opts)
end

-- Macos alt key remaps
nvmapNoRemap("˙", "<M-h>")
nvmapNoRemap("∆", "<M-j>")
nvmapNoRemap("˚", "<M-k>")
nvmapNoRemap("¬", "<M-l>")

local function termcodes(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local M = {}

M.general = {

	i = {},

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
		["<C-x>"] = { termcodes("<C-\\><C-N>"), "   escape terminal mode" },
		-- -- Map escape to escape sequence in terminal buffer.
		-- tmap("<Esc>", "<C-\\><C-n>")
	},
}

-- M.tabufline = {
M.bufferline = {
	n = {
		-- cycle through buffers
		["<TAB>"] = { "<cmd> BufferNext <CR>", "  goto next buffer" }, -- BufferNext
		["<S-Tab>"] = { "<cmd> BufferPrevious <CR> ", "  goto prev buffer" }, -- BufferPrevious

		-- cycle through tabs
		["<leader>tp"] = { "<cmd> tabprevious <CR>", "  goto next tab" },
		["<leader>tn"] = { "<cmd> tabnext <CR> ", "  goto prev tab" },
		["<leader>q"] = { "<cmd> BufferClose <CR>", "   close buffer" },
	},
}

M.comment = {

	-- toggle comment in both modes
	n = {
		["gcc"] = {
			"<Plug>(comment_toggle_linewise_current)",
			"蘒  toggle comment",
		},
	},

	v = {
		["gc"] = {
			"<Plug>(comment_toggle_linewise_visual)",
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
			"<cmd> Telescope lsp_definitions <CR>",
			"   lsp definition",
		},

		["K"] = {
			function()
				vim.lsp.buf.hover()
			end,
			"   lsp hover",
		},

		["gi"] = {
			"<cmd> Telescope lsp_implementations <CR>",
			"   lsp implementation",
		},

		["<leader>ls"] = {
			function()
				vim.lsp.buf.signature_help()
			end,
			"   lsp signature_help",
		},

		["<leader>D"] = {
			"<cmd> Telescope lsp_type_definitions <CR>",
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
			"<cmd> Telescope lsp_references <CR>",
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

		["]d"] = {
			function()
				vim.diagnostic.goto_next()
			end,
			"   goto_next",
		},

		["<leader>fm"] = {
			function()
				vim.lsp.buf.format({ async = true })
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
		["<C-n>"] = { "<cmd> NeoTreeFloatToggle <CR>", "   toggle neotree" },

		-- focus
		["<leader>e"] = { "<cmd> NeoTreeFocus <CR>", "   focus neotree" },
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
		["<leader>qf"] = { "<cmd> Telescope quickfix <CR>", "   quickfix list" },

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

M.whichkey = {
	n = {
		["<leader>wK"] = {
			function()
				vim.cmd("WhichKey")
			end,
			"   which-key all keymaps",
		},
		["<leader>wk"] = {
			function()
				local input = vim.fn.input("WhichKey: ")
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
					vim.cmd([[normal! _]])
				end
			end,

			"  Jump to current_context",
		},
	},
}

M.gitsigns = {
	n = {
		["]c"] = {
			function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					require("gitsigns").next_hunk()
				end)
				return "<Ignore>"
			end,
			"git next hunk",
		},
		["[c"] = {
			function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					require("gitsigns").prev_hunk()
				end)
				return "<Ignore>"
			end,
			"git previous hunk",
		},
		["<leader>hs"] = {
			function()
				require("gitsigns").stage_hunk()
			end,
			"git stage hunk",
		},
		["<leader>hu"] = {
			function()
				require("gitsigns").undo_stage_hunk()
			end,
			"git unstage hunk",
		},
		["<leader>hr"] = {
			function()
				require("gitsigns").reset_hunk()
			end,
			"git reset hunk",
		},
		["<leader>hp"] = {
			function()
				require("gitsigns").preview_hunk()
			end,
			"git preview hunk",
		},
		["<leader>hb"] = {
			function()
				require("gitsigns").blame_line()
			end,
			"git blame line",
		},
	},
}

M.testing = {
	n = {
		["tn"] = {
			function()
				require("neotest").run.run()
				-- require'neotest'.run.run({strategy = "dap"}) requires nvim-dap
			end,
			"run nearest test",
		},
		["tf"] = {
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			"run all tests in file",
		},
		["ta"] = {
			function()
				require("neotest").run.run(vim.fn.getcwd())
			end,
			"run all tests",
		},
		["tl"] = {
			function()
				require("neotest").run.run_last()
			end,
			"run last test",
		},
		["ts"] = {
			function()
				require("neotest").summary.toggle()
			end,
			"toggle test summary",
		},
	},
}

return M
