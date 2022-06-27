-- Mappers
local mapper_tele = require("plugin.telescope.mapping")
local mapper = function(mode, key, result)
	vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua " .. result .. "<CR>", { noremap = true, silent = true })
end

local on_attach = function(client, _)
	mapper("n", "gD", "vim.lsp.buf.declaration()")
	mapper("n", "K", "vim.lsp.buf.hover()")
	mapper("n", "gh", "vim.lsp.buf.signature_help()")
	mapper("n", "gl", 'vim.diagnostic.open_float(nil, { source = "always" })')
	mapper("n", "gR", "vim.lsp.buf.rename()")
	mapper("n", "gp", "vim.diagnostic.goto_prev()")
	mapper("n", "gn", "vim.diagnostic.goto_next()")

	mapper_tele("gd", "lsp_definitions", nil, true)
	mapper_tele("gi", "lsp_implementations", nil, true)
	mapper_tele("gtd", "lsp_type_definitions", nil, true)
	mapper("n", "ga", "vim.lsp.buf.code_action()<CR>")
	mapper_tele("gr", "lsp_references", nil, true)

	mapper_tele("<leader>wd", "lsp_document_symbols", { ignore_filename = true }, true)
	mapper_tele("<leader>ww", "lsp_workspace_symbols", { ignore_filename = true }, true)

	vim.api.nvim_buf_set_keymap(0, "n", "<leader>xx", "<cmd>TroubleToggle<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(0, "n", "<C-s>", [[ :lua require'plugin.sidebar'.open() <CR> ]], { noremap = true, silent = true })

	mapper("n", "<leader>wa", "vim.lsp.buf.add_workspace_folder()<CR>")
	mapper("n", "<leader>wr", "vim.lsp.buf.remove_workspace_folder()<CR>")
	mapper("n", "<leader>wl", "P(vim.lsp.buf.list_workspace_folders())")

	-- Set some keybinds conditional on server capabilities
	if client.server_capabilities.documentFormattingProvider or client.server_capabilities.documentRangeFormattingProvider then
		mapper("n", "<leader>vr", "vim.lsp.buf.range_formatting()")
		mapper("n", "<leader>r", "vim.lsp.buf.format { async = true }")
	end

	-- Reset LSP and reload Buffer
	mapper("n", "<space>rr", "vim.lsp.stop_client(vim.lsp.get_active_clients()); vim.cmd [[e]]")
end

return on_attach
