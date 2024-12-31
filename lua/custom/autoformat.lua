local setup = function()
    -- Autoformatting Setup
    local js_formatters = { { "eslint_d", "prettierd", "prettier" } }
    local conform = require("conform")
    conform.setup({
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
            -- nix = { "nixpkgs_fmt" },
            -- sql = { "sqlfluff" },
            python = { "black" },
            -- vue = js_formatters,
            typescript = js_formatters,
            typescriptreact = js_formatters,
            javascript = js_formatters,
            javascriptreact = js_formatters,
        },
        formatters = {
            ["php-cs-fixer"] = function()
                return {
                    command = require("conform.util").find_executable({
                        "vendor/bin/php-cs-fixer",
                    }, "php-cs-fixer"),
                    args = { "fix", "$FILENAME" },
                    stdin = false,
                }
            end,
        },
    })

    conform.formatters.injected = {
        options = {
            ignore_errors = false,
            lang_to_formatters = {
                sql = { "sleek" },
            },
        },
    }

    vim.keymap.set("n", "<leader>cf", function()
        conform.format({ lsp_fallback = true })
    end, { desc = "Autoformat" })

    vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function(args)
            require("conform").format({
                bufnr = args.buf,
                lsp_fallback = true,
                quiet = true,
            })
        end,
    })
end

setup()

return { setup = setup }
