-- Mappers
local mapper_tele = require'plugin.telescope.mapping'
local mapper = function(mode, key, result)
	vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua " .. result .. "<CR>", {noremap = true, silent = true})
end

local function mappings(client)
	mapper('n', 'gD', 'vim.lsp.buf.declaration()')
	mapper('n', 'gd', 'vim.lsp.buf.definition()')
	mapper('n', 'K', 'vim.lsp.buf.hover()')
	mapper('n', 'gi', 'vim.lsp.buf.implementation()')
	mapper('n', 'gh', 'vim.lsp.buf.signature_help()')
	mapper('n', 'gl', 'vim.lsp.diagnostic.show_line_diagnostics()')
	mapper('n', '1gD', 'vim.lsp.buf.type_definition()')
	mapper('n', 'gR', 'vim.lsp.buf.rename()')
	mapper('n', 'gp', 'vim.lsp.diagnostic.goto_prev()')
	mapper('n', 'gn', 'vim.lsp.diagnostic.goto_next()')

	mapper_tele('ga', 'lsp_code_actions', nil, true)
	mapper_tele('gr', 'lsp_references', nil, true)

	mapper_tele('<leader>wd', 'lsp_document_symbols', { ignore_filename = true }, true)
	mapper_tele('<leader>ww', 'lsp_workspace_symbols', { ignore_filename = true }, true)

	vim.api.nvim_buf_set_keymap(0, 'n', '<leader>xx', "<cmd>LspTroubleToggle<CR>", {noremap = true, silent = true})
	vim.api.nvim_buf_set_keymap(0, 'n', '<C-s>', "<cmd>SymbolsOutline<CR>", {noremap = true, silent = true})

	mapper('n', '<leader>wa', 'vim.lsp.buf.add_workspace_folder()<CR>')
	mapper('n', '<leader>wr', 'vim.lsp.buf.remove_workspace_folder()<CR>')
	mapper('n', '<leader>wl', 'P(vim.lsp.buf.list_workspace_folders())')

	mapper('n', '<leader>wa', 'vim.lsp.buf.add_workspace_folder()<CR>')
	mapper('n', '<leader>wr', 'vim.lsp.buf.remove_workspace_folder()<CR>')
	mapper('n', '<leader>wl', 'P(vim.lsp.buf.list_workspace_folders())')

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting or client.resolved_capabilities.document_range_formatting then
		mapper('n', '<leader>r', 'vim.lsp.buf.formatting()')
	end

	-- Reset LSP and reload Buffer
	mapper('n', '<space>rr', 'vim.lsp.stop_client(vim.lsp.get_active_clients()); vim.cmd [[e]]')
end

local on_attach = function(client, bufnr)
	-- LSP supported highlighting
	require'illuminate'.on_attach(client) 
	vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
	vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

	mappings(client)

	if filetype == 'rust' then
		vim.cmd([[autocmd BufEnter,BufWritePost <buffer> :lua require('plugin.lsp.extensions').show_line_hints() <CR>]])
	end

	-- Only EFM for document_formatting
	if client.name ~= 'efm' then client.resolved_capabilities.document_formatting = false end
	if client.resolved_capabilities.document_formatting then
		vim.cmd[[autocmd! BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]]
	end

	-- Except Intelephense
	if client.name == 'php' then client.resolved_capabilities.document_formatting = true end
end

return on_attach