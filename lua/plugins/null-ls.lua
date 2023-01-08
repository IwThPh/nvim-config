local M = {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
        'neovim/nvim-lspconfig',
        'SmiteshP/nvim-navic',
    },
}

function M.config()
    local null_ls = require('null-ls')
    null_ls.setup({
        on_attach = function(client, bufnr)
            local navic = require('nvim-navic')

            -- Set formatting providers
            client.server_capabilities.documentFormattingProvider = true
            client.server_capabilities.documentRangeFormattingProvider = true

            require('core.mappings').lsp_mappings({ buffer = bufnr })

            if client.server_capabilities.documentSymbolProvider then
                navic.attach(client, bufnr)
            end
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
end

return M
