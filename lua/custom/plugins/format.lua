local Util = require("custom.util")
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
            {
                "<leader>cF",
                function()
                    require("conform").format({ formatters = { "injected" } })
                end,
                mode = { "n", "v" },
                desc = "Format Injected Langs",
            },
        },
        init = function()
            -- Install the conform formatter on VeryLazy
            require("custom.util").on_very_lazy(function()
                require("custom.util").format.register({
                    name = "conform.nvim",
                    priority = 100,
                    primary = true,
                    format = function(buf)
                        local plugin = require("lazy.core.config").plugins["conform.nvim"]
                        local Plugin = require("lazy.core.plugin")
                        local opts = Plugin.values(plugin, "opts", false)
                        require("conform").format(Util.merge(opts.format, { bufnr = buf }))
                    end,
                    sources = function(buf)
                        local ret = require("conform").list_formatters(buf)
                        ---@param v conform.FormatterInfo
                        return vim.tbl_map(function(v)
                            return v.name
                        end, ret)
                    end,
                })
            end)
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
                ---@type table<string, conform.FormatterUnit[]>
                formatters_by_ft = {
                    lua = { "stylua" },
                    sh = { "shfmt" },
                    php = { { "php-cs-fixer", "pint" } },
                    blade = { "blade-formatter" },
                    vue = js_formatters,
                    typescript = js_formatters,
                    javascript = js_formatters,
                },
                -- The options you set here will be merged with the builtin formatters.
                -- You can also define any custom formatters here.
                ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
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
