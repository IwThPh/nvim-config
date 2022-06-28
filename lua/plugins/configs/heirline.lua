local present, heirline = pcall(require, "heirline")

if not present then
   return
end

local sep_style = require("ui.icons").statusline_separators
local user_sep = require("core.utils").load_config().ui.statusline.separator_style
local sep_l = sep_style[user_sep]["left"]
local sep_r = sep_style[user_sep]["right"]

local function lspSymbol(name, icon)
   local hl = "DiagnosticSign" .. name
   vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

lspSymbol("Error", "")
lspSymbol("Info", "")
lspSymbol("Hint", "")
lspSymbol("Warn", "")

local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local palette = require('ui.theme').get_palette()

local colors = {
	red = palette.red.base,
	green = palette.green.base,
	blue = palette.blue.base,
	gray = palette.white.dim,
	orange = palette.orange.base,
	purple = palette.magenta.base,
	cyan = palette.cyan.base,
	diag = {
		warn = utils.get_highlight("DiagnosticWarn").fg,
		error = utils.get_highlight("DiagnosticError").fg,
		hint = utils.get_highlight("DiagnosticHint").fg,
		info = utils.get_highlight("DiagnosticInfo").fg,
	},
	git = {
		del = utils.get_highlight("diffRemoved").fg,
		add = utils.get_highlight("diffAdded").fg,
		change = utils.get_highlight("diffChanged").fg,
	},
}

local Align = { provider = "%=" }
local Space = { provider = " " }
local modes = {
   ["n"] = { "NORMAL", palette.red.base },
   ["niI"] = { "NORMAL i", palette.red.base },
   ["niR"] = { "NORMAL r", palette.red.base },
   ["niV"] = { "NORMAL v", palette.red.base },
   ["no"] = { "N-PENDING", palette.red.base },
   ["i"] = { "INSERT", palette.yellow.base },
   ["ic"] = { "INSERT", palette.yellow.base },
   ["ix"] = { "INSERT completion", palette.yellow.base },
   ["t"] = { "TERMINAL", palette.green.base },
   ["nt"] = { "NTERMINAL", palette.green.base},
   ["v"] = { "VISUAL", palette.blue.base },
   ["V"] = { "V-LINE", palette.blue.base },
   [""] = { "V-BLOCK", palette.blue.base },
   ["R"] = { "REPLACE", palette.cyan.base },
   ["Rv"] = { "V-REPLACE", palette.cyan.base },
   ["s"] = { "SELECT", palette.pink.base },
   ["S"] = { "S-LINE", palette.pink.base },
   ["c"] = { "COMMAND", palette.orange.base },
   ["cv"] = { "COMMAND", palette.orange.base },
   ["ce"] = { "COMMAND", palette.orange.base },
   ["r"] = { "PROMPT", palette.pink.base },
   ["rm"] = { "MORE", palette.pink.base },
   ["r?"] = { "CONFIRM", palette.pink.base },
   ["!"] = { "SHELL", palette.green.base },
}

local ViMode = {
	{
		init = function(self) self.mode = vim.api.nvim_get_mode().mode end,
		provider = function(self) return "  " .. modes[self.mode][1] .. " " end,
		hl = function(self) return { bg = modes[self.mode][2] } end,
	},
	{
		init = function(self) self.mode = vim.api.nvim_get_mode().mode end,
		provider = function() return sep_r end,
		hl = function(self) return { bg = palette.bg2, fg = modes[self.mode][2] } end,
	},
	{
		provider = function() return sep_r end,
		hl = function() return { bg = palette.bg1, fg = palette.bg2 } end,
	}
}

local FileNameBlock = {
	-- let's first set up some attributes needed by this component and it's children
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
	hl = function() return { fg = palette.fg1, bg = palette.bg1 } end,
}
-- We can now define some children separately and add them later

local FileIcon = {
	init = function(self)
		local filename = self.filename
		local extension = vim.fn.fnamemodify(filename, ":e")
		self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(
			filename,
			extension,
			{ default = true }
		)
	end,
	provider = function(self) return self.icon end,
	hl = function(self) return { fg = self.icon_color } end,
}

local FileName = {
	provider = function(self)
		-- first, trim the pattern relative to the current directory. For other
		-- options, see :h filename-modifers
		local filename = vim.fn.fnamemodify(self.filename, ":.")
		if filename == "" then
			return "[No Name]"
		end
		-- now, if the filename would occupy more than 1/4th of the available
		-- space, we trim the file path to its initials
		-- See Flexible Components section below for dynamic truncation
		if not conditions.width_percent_below(#filename, 0.25) then
			filename = vim.fn.pathshorten(filename)
		end
		return " " .. filename .. " "
	end,
	hl = { fg = palette.fg2 },
}

local FileFlags = {
	{
		provider = function()
			if vim.bo.modified then
				return "[+]"
			end
		end,
		hl = { fg = colors.green },
	},
	{
		provider = function()
			if not vim.bo.modifiable or vim.bo.readonly then
				return ""
			end
		end,
		hl = { fg = colors.orange },
	},
}

-- Now, let's say that we want the filename color to change if the buffer is
-- modified. Of course, we could do that directly using the FileName.hl field,
-- but we'll see how easy it is to alter existing components using a "modifier"
-- component

local FileNameModifer = {
	hl = function()
		if vim.bo.modified then
			-- use `force` because we need to override the child's hl foreground
			return { fg = colors.cyan, bold = true, force = true }
		end
	end,
}

-- let's add the children to our FileNameBlock component
FileNameBlock = utils.insert(
	FileNameBlock,
	FileIcon,
	utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
	unpack(FileFlags), -- A small optimisation, since their parent does nothing
	{
		provider = function() return sep_r end,
		hl = function() return { bg = palette.bg0, fg = palette.bg1 } end,
	},
	{ provider = "%<" } -- this means that the statusline is cut here when there's not enough space
)

local Git = {
	condition = conditions.is_git_repo,

	on_click = {
		callback = function(self, minwid, nclicks, button)
			vim.defer_fn(function() vim.cmd("Telescope git_branches") end, 100)
        end,
        name = "heirline_git",
	},

	static = {
		add_icon = "  " ,
		change_icon = "  " ,
		delete_icon = "  " ,
	},

	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
	end,

	hl = { fg = palette.fg1 },

	{ -- git branch name
		provider = function(self)
			return " " .. self.status_dict.head
		end,
		hl = { bold = true },
	},
	-- You could handle delimiters, icons and counts similar to Diagnostics
	{
		provider = function(self)
			local count = self.status_dict.added or 0
			return count > 0 and (self.add_icon .. count)
		end,
		hl = { fg = colors.git.add },
	},
	{
		provider = function(self)
			local count = self.status_dict.removed or 0
			return count > 0 and (self.delete_icon .. count)
		end,
		hl = { fg = colors.git.del },
	},
	{
		provider = function(self)
			local count = self.status_dict.changed or 0
			return count > 0 and (self.change_icon .. count)
		end,
		hl = { fg = colors.git.change },
	},
}

local Diagnostics = {

	condition = conditions.has_diagnostics,

	static = {
		error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
		warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
		info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
		hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
	},

	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,

	{
		provider = "![",
	},
	{
		provider = function(self)
			-- 0 is just another output, we can decide to print it or not!
			return self.errors > 0 and (self.error_icon .. self.errors .. " ")
		end,
		hl = { fg = colors.diag.error },
	},
	{
		provider = function(self)
			return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
		end,
		hl = { fg = colors.diag.warn },
	},
	{
		provider = function(self)
			return self.info > 0 and (self.info_icon .. self.info .. " ")
		end,
		hl = { fg = colors.diag.info },
	},
	{
		provider = function(self)
			return self.hints > 0 and (self.hint_icon .. self.hints)
		end,
		hl = { fg = colors.diag.hint },
	},
	{
		provider = "]",
	},
}

local HelpFileName = {
	condition = function()
		return vim.bo.filetype == "help"
	end,
	provider = function()
		local filename = vim.api.nvim_buf_get_name(0)
		return vim.fn.fnamemodify(filename, ":t")
	end,
	hl = { fg = colors.blue },
}

local FileType = {
	provider = function()
		return string.upper(vim.bo.filetype)
	end,
	hl = { fg = utils.get_highlight("Type").fg, bold = true },
}

local Spell = {
	condition = function()
		return vim.wo.spell
	end,
	provider = "SPELL ",
	hl = { bold = true, fg = colors.orange },
}

-- We're getting minimalists here!
local Ruler = {
	-- %l = current line number
	-- %L = number of lines in the buffer
	-- %c = column number
	-- %P = percentage through file of displayed window
	provider = "%7(%l/%3L%):%2c %P",
}

-- I take no credits for this! :lion:
local ScrollBar = {
	static = {
		sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
		-- Another variant, because the more choice the better.
		-- sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
	},
	provider = function(self)
		local curr_line = vim.api.nvim_win_get_cursor(0)[1]
		local lines = vim.api.nvim_buf_line_count(0)
		local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
		return string.rep(self.sbar[i], 2)
	end,
	hl = { fg = colors.blue, bg = colors.bright_bg },
}

local LSPActive = {
	condition = conditions.lsp_attached,

	on_click = {
		callback = function(self, minwid, nclicks, button)
			vim.lsp.stop_client(vim.lsp.get_active_clients())
			vim.defer_fn(function() vim.cmd [[e]] end, 100)
        end,
        name = "heirline_lspactive",
	},

	-- You can keep it simple,
	-- provider = " [LSP]",

	-- Or complicate things a bit and get the servers names
	provider = function()
		local names = {}
		for i, server in pairs(vim.lsp.buf_get_clients(0)) do
			table.insert(names, server.name)
		end
		return " [" .. table.concat(names, " ") .. "]"
	end,
	hl = { fg = colors.green, bold = true },
}

local TerminalName = {
	-- we could add a condition to check that buftype == 'terminal'
	-- or we could do that later (see #conditional-statuslines below)
	provider = function()
		local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
		return " " .. tname
	end,
	hl = { fg = colors.blue, bold = true },
}

local DefaultStatusline = {
	ViMode,
	FileNameBlock,
	Git,
	Diagnostics,
	Align,
	LSPActive,
	Space,
	Space,
	FileType,
	Space,
	Ruler,
	Space,
	ScrollBar,
}

local SpecialStatusline = {
	condition = function()
		return conditions.buffer_matches({
			buftype = { "nofile", "prompt", "help", "quickfix" },
			filetype = { "^git.*", "fugitive" },
		})
	end,

	FileType,
	Space,
	HelpFileName,
	Align,
}

local TerminalStatusline = {

	condition = function()
		return conditions.buffer_matches({ buftype = { "terminal" } })
	end,

	hl = { bg = colors.dark_red },

	-- Quickly add a condition to the ViMode to only show it when buffer is active!
	{ condition = conditions.is_active, ViMode, Space },
	FileType,
	Space,
	TerminalName,
	Align,
}

local statuslines = {
	hl = function()
		if conditions.is_active() then
			return {
				fg = utils.get_highlight("StatusLine").fg,
				bg = utils.get_highlight("StatusLine").bg,
			}
		else
			return {
				fg = utils.get_highlight("StatusLineNC").fg,
				bg = utils.get_highlight("StatusLineNC").bg,
			}
		end
	end,

	init = utils.pick_child_on_condition,

	SpecialStatusline,
	TerminalStatusline,
	DefaultStatusline,
}

--TODO: Winbar
heirline.setup(statuslines)
