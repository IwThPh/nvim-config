local util = require 'vim.lsp.util'

local border = {
	{ "╭", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╮", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "╯", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╰", "FloatBorder" },
	{ "│", "FloatBorder" },
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
})

function no_notify_hover(_, result, ctx, config)
	config = config or {}
	config.focus_id = ctx.method
	if not (result and result.contents) then
		return
	end
	local markdown_lines = util.convert_input_to_markdown_lines(result.contents)
	markdown_lines = util.trim_empty_lines(markdown_lines)
	if vim.tbl_isempty(markdown_lines) then
		return
	end
	return util.open_floating_preview(markdown_lines, "markdown", config)
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(no_notify_hover, { border = border })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })

vim.fn.sign_define("DiagnosticSignError", { text = "" })
vim.fn.sign_define("DiagnosticSignWarning", { text = "" })
vim.fn.sign_define("DiagnosticSignInformation", { text = "" })
vim.fn.sign_define("DiagnosticSignHint", { text = "" })
