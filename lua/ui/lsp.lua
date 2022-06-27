local function lspSymbol(name, icon)
   local hl = "DiagnosticSign" .. name
   vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

lspSymbol("Error", "")
lspSymbol("Info", "")
lspSymbol("Hint", "")
lspSymbol("Warn", "")

local border = {
	{ "╭", "TelescopeBorder" },
	{ "─", "TelescopeBorder" },
	{ "╮", "TelescopeBorder" },
	{ "│", "TelescopeBorder" },
	{ "╯", "TelescopeBorder" },
	{ "─", "TelescopeBorder" },
	{ "╰", "TelescopeBorder" },
	{ "│", "TelescopeBorder" },
}

vim.diagnostic.config {
   virtual_text = {
      prefix = "",
   },
   signs = true,
   underline = true,
   update_in_insert = false,
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

-- suppress error messages from lang servers
vim.notify = function(msg, log_level)
	vim.api.nvim_echo({ { msg } }, true, {})

   if msg:match "exit code" then
      return
   end

   if msg:match "No information available" then
	vim.api.nvim_echo({ { msg } }, true, {})
      return
   end

   local present, notify = pcall(require, "notify")
   if not (present) then
	   if log_level == vim.log.levels.ERROR then
		  vim.api.nvim_err_writeln(msg)
	   else
		  vim.api.nvim_echo({ { msg } }, true, {})
	   end
		return
   end

    vim.notify = notify
end

-- Borders for LspInfo winodw
local win = require "lspconfig.ui.windows"
local _default_opts = win.default_opts

win.default_opts = function(options)
   local opts = _default_opts(options)
   opts.border = "single"
   return opts
end
