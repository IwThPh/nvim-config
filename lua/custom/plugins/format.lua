-- format.lua
--
-- Use your language server to automatically format your code on save.
-- Adds additional commands as well to manage the behavior

return {
    {
        "stevearc/conform.nvim",
        dependencies = { "mason.nvim" },
        lazy = true,
        cmd = "ConformInfo",
        keys = {
            -- stylua: ignore start
            { "<leader>cf", function() require("conform").format({ lsp_fallback = true }) end, mode = { "n", "v" }, desc = "Format" },
            { "<leader>cF", function() require("conform").format({ formatters = { "injected" } }) end, mode = { "n", "v" }, desc = "Format Injected Langs" },
            -- stylua: ignore end
        },
        config = function()
            vim.api.nvim_create_autocmd("BufWritePre", {
                callback = function(args)
                    require("conform").format({
                        bufnr = args.buf,
                        lsp_fallback = true,
                        quiet = true,
                    })
                end,
            })
        end,
        opts = function()
            local js_formatters = { { "eslint_d", "prettierd", "prettier" } }

            ---@class ConformOpts
            return {
                format = {
                    timeout_ms = 3000,
                    async = false,
                    quiet = false,
                    lsp_fallback = true,
                },
                formatters_by_ft = {
                    lua = { "stylua" },
                    sh = { "shfmt" },
                    php = { { "php-cs-fixer", "pint" } },
                    blade = { "blade-formatter" },
                    nix = { "nixpkgs_fmt" },
                    sql = { "sqlfmt" },
                    vue = js_formatters,
                    typescript = js_formatters,
                    javascript = js_formatters,
                },
                -- The options you set here will be merged with the builtin formatters.
                -- You can also define any custom formatters here.
                formatters = {
                    injected = { options = { ignore_errors = true } },
                    -- # Example of using dprint only when a dprint.json file is present
                    -- dprint = {
                    --   condition = function(ctx)
                    --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
                    --   end,
                    -- },
                    --
                    -- # Example of using shfmt with extra args
                    -- shfmt = {
                    --   prepend_args = { "-i", "2", "-ci" },
                    -- },
                    ["php-cs-fixer"] = function(bufnr)
                        return {
                            command = require("conform.util").find_executable({
                                "vendor/bin/php-cs-fixer",
                            }, "php-cs-fixer"),
                            args = { "fix", "$FILENAME" },
                            stdin = false,
                        }
                    end,
                },
            }
        end,
    },
}
