local null_ls = require("null-ls")

null_ls.config({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.sqlformat,
		null_ls.builtins.formatting.eslint_d,
		-- null_ls.builtins.formatting.prettier,
		-- null_ls.builtins.formatting.fixjson,

		null_ls.builtins.diagnostics.write_good,

		-- null_ls.builtins.diagnostics.phpstan,
		-- null_ls.builtins.diagnostics.psalm,
		-- null_ls.builtins.diagnostics.phpcs,

		-- null_ls.builtins.code_actions.gitsigns,
	},
})
