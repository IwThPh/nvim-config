-- Mappers
local mapper_tele = require'plugin.telescope.mapping'
local mapper = function(mode, key, result)
	vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua " .. result .. "<CR>", {noremap = true, silent = true})
end

local function mappings(client)
	mapper('n', 'gD', 'vim.lsp.buf.declaration()')
	mapper('n', 'K', 'vim.lsp.buf.hover()')
	mapper('n', 'gh', 'vim.lsp.buf.signature_help()')
	mapper('n', 'gl', 'vim.lsp.diagnostic.show_line_diagnostics()')
	mapper('n', 'gR', 'vim.lsp.buf.rename()')
	mapper('n', 'gp', 'vim.lsp.diagnostic.goto_prev()')
	mapper('n', 'gn', 'vim.lsp.diagnostic.goto_next()')

	mapper_tele('gd', 'lsp_definitions', nil, true)
	mapper_tele('gi', 'lsp_implementations', nil, true)
	mapper_tele('gtd', 'lsp_type_definitions', nil, true)
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
		mapper('n', '<leader>vr', 'vim.lsp.buf.range_formatting()')
	end

	-- Reset LSP and reload Buffer
	mapper('n', '<space>rr', 'vim.lsp.stop_client(vim.lsp.get_active_clients()); vim.cmd [[e]]')
end

local on_attach = function(client, _)
	mappings(client)

	if client.name == 'rust' then
		vim.cmd([[autocmd BufEnter,BufWritePost <buffer> :lua require('plugin.lsp.extensions').show_line_hints() <CR>]])
	end

	-- Only EFM for document_formatting
	if client.name ~= 'efm' then client.resolved_capabilities.document_formatting = false end
	if client.resolved_capabilities.document_formatting then
		vim.cmd[[autocmd! BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]]
	end

	-- Except Intelephense
	if client.name == 'php' then
		client.resolved_capabilities.document_formatting = true
	end

	if client.name == "tsserver" then
		-- disable tsserver formatting if you plan on formatting via null-ls
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false

		local ts_utils = require("nvim-lsp-ts-utils")
		-- defaults
        ts_utils.setup {
            debug = true,
            disable_commands = false,
            enable_import_on_completion = false,

            -- import all
            import_all_timeout = 5000, -- ms
            -- lower numbers indicate higher priority
            import_all_priorities = {
                same_file = 1, -- add to existing import statement
                local_files = 2, -- git files or files with relative path markers
                buffer_content = 3, -- loaded buffer content
                buffers = 4, -- loaded buffer names
            },
            import_all_scan_buffers = 100,
            import_all_select_source = false,

            -- eslint
            eslint_enable_code_actions = true,
            eslint_enable_disable_comments = true,
            eslint_bin = "eslint_d",
            eslint_enable_diagnostics = false,
            eslint_opts = {},

            -- formatting
            enable_formatting = false,
            formatter = "prettier",
            formatter_opts = {},

            -- update imports on file move
            update_imports_on_move = false,
            require_confirmation_on_move = false,
            watch_dir = nil,

            -- filter diagnostics
            filter_out_diagnostics_by_severity = {},
            filter_out_diagnostics_by_code = {},
        }

        -- required to fix code action ranges and filter diagnostics
        ts_utils.setup_client(client)
	end


end

return on_attach
