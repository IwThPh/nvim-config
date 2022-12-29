local present, null_ls = pcall(require, "null-ls")

if not present then
	return
end

null_ls.setup({
	on_attach = function(client, bufnr)
		-- Default on attach
		require("plugins.configs.lspconfig").on_attach(client, bufnr)
		-- Set formatting providers
		client.server_capabilities.documentFormattingProvider = true
		client.server_capabilities.documentRangeFormattingProvider = true
	end,
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.sqlformat,
		null_ls.builtins.formatting.eslint_d,
		null_ls.builtins.formatting.terraform_fmt,
		null_ls.builtins.formatting.prettierd,
		-- null_ls.builtins.formatting.fixjson,
		null_ls.builtins.formatting.phpcsfixer,

		-- null_ls.builtins.diagnostics.write_good,
		-- null_ls.builtins.diagnostics.phpstan.with({
		-- 	command = "docker",
		-- 	args = {
		-- 		"run", "-v", "$PWD:/app", "--rm", "ghcr.io/phpstan/phpstan", "analyze", "--error-format", "json", "--level", "1", "--no-progress", "$FILENAME",
		-- 	},
		-- 	method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
		-- }),
		-- null_ls.builtins.diagnostics.psalm,

		-- null_ls.builtins.code_actions.gitsigns,
	},
})
