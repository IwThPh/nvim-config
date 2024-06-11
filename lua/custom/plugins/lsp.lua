return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "Hoffs/omnisharp-extended-lsp.nvim",

            { "j-hui/fidget.nvim", opts = {} },

            -- Schema information
            "b0o/SchemaStore.nvim",
        },
        config = function()
            local capabilities = nil
            if pcall(require, "cmp_nvim_lsp") then
                capabilities = require("cmp_nvim_lsp").default_capabilities()
            end

            local lspconfig = require("lspconfig")

            local servers = {
                bashls = true,
                lua_ls = true,
                rust_analyzer = true,
                cssls = true,

                intelephense = {
                    init_options = { licenceKey = vim.fn.expand("~/.config/intelephense/licence.txt") },
                    settings = { intelephense = { environment = { phpVersion = "" } } },
                },

                volar = true,
                helm_ls = true,

                tsserver = true,
                -- init_options = {
                --     plugins = {
                --         {
                --             name = "@vue/typescript-plugin",
                --             location = vim.fn.expand(
                --                 "~/.nvm/versions/node/v16.16.0/lib/node_modules/@vue/language-server"
                --             ),
                --             languages = { "vue" },
                --         },
                --     },
                -- },
                -- },

                omnisharp = {
                    cmd = {
                        vim.fn.stdpath("data") .. "/mason/bin/" .. "omnisharp",
                    },
                    settings = {
                        FormattingOptions = {
                            -- Enables support for reading code style, naming convention and analyzer
                            -- settings from .editorconfig.
                            EnableEditorConfigSupport = true,
                            -- Specifies whether 'using' directives should be grouped and sorted during
                            -- document formatting.
                            OrganizeImports = false,
                        },
                        MsBuild = {
                            -- If true, MSBuild project system will only load projects for files that
                            -- were opened in the editor. This setting is useful for big C# codebases
                            -- and allows for faster initialization of code navigation features only
                            -- for projects that are relevant to code that is being edited. With this
                            -- setting enabled OmniSharp may load fewer projects and may thus display
                            -- incomplete reference lists for symbols.
                            LoadProjectsOnDemand = false,
                        },
                        RoslynExtensionsOptions = {
                            -- Enables support for roslyn analyzers, code fixes and rulesets.
                            EnableAnalyzersSupport = true,
                            -- Enables support for showing unimported types and unimported extension
                            -- methods in completion lists. When committed, the appropriate using
                            -- directive will be added at the top of the current file. This option can
                            -- have a negative impact on initial completion responsiveness,
                            -- particularly for the first few completion sessions after opening a
                            -- solution.
                            EnableImportCompletion = true,
                            -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
                            -- true
                            AnalyzeOpenDocumentsOnly = false,
                        },
                        Sdk = {
                            -- Specifies whether to include preview versions of the .NET SDK when
                            -- determining which version to use for project loading.
                            IncludePrereleases = false,
                        },
                    },
                },

                jsonls = {
                    settings = {
                        json = {
                            schemas = require("schemastore").json.schemas(),
                            validate = { enable = true },
                        },
                    },
                },

                yamlls = {
                    settings = {
                        yaml = {
                            schemaStore = {
                                enable = false,
                                url = "",
                            },
                            schemas = require("schemastore").yaml.schemas(),
                        },
                    },
                },
            }

            local servers_to_install = vim.tbl_filter(function(key)
                local t = servers[key]
                if type(t) == "table" then
                    return not t.manual_install
                else
                    return t
                end
            end, vim.tbl_keys(servers))

            require("mason").setup()
            local ensure_installed = {
                "stylua",
                "lua_ls",
                -- "tailwind-language-server",
            }

            vim.list_extend(ensure_installed, servers_to_install)
            require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

            for name, config in pairs(servers) do
                if config == true then
                    config = {}
                end
                config = vim.tbl_deep_extend("force", {}, {
                    capabilities = capabilities,
                }, config)

                lspconfig[name].setup(config)
            end

            local disable_semantic_tokens = {
                lua = true,
            }

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

                    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
                    local Util = require("custom.util")

                    -- stylua: ignore start
                    vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "Lsp Info", buffer = 0 })
                    vim.keymap.set("n", "gd", Util.telescope("lsp_definitions"), { desc = "Goto Definition", buffer = 0 })
                    vim.keymap.set("n", "gr", Util.telescope("lsp_references"), { desc = "References", buffer = 0 })
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration", buffer = 0 })
                    vim.keymap.set("n", "gT", Util.telescope("lsp_type_definition"), { desc = "Goto Type Definition", buffer = 0 })
                    vim.keymap.set("n", "gI", Util.telescope("lsp_implementations"), { desc = "Goto Implementation", buffer = 0 })
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover", buffer = 0 })
                    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename", buffer = 0 })
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", buffer = 0 })
                    vim.keymap.set({ "n", "v" }, "<leader>cA", function() vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } }) end, { desc = "Source Action", buffer = 0 })
                    vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help", buffer = 0 })
                    vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help", buffer = 0 })
                    -- stylua: ignore end

                    if client.name == "omnisharp" then
                        local ose = require("omnisharp_extended")
                        -- stylua: ignore start
                        vim.keymap.set("n", "gd", function() ose.telescope_lsp_definitions(Util.telescope.theme()) end, { desc = "Goto Definition", buffer = 0 })
                        vim.keymap.set("n", "gr", function() ose.telescope_lsp_references(Util.telescope.theme()) end, { desc = "References", buffer = 0 })
                        vim.keymap.set("n", "gT", function() ose.telescope_lsp_type_definition(Util.telescope.theme()) end, { desc = "Goto Type Definition", buffer = 0 })
                        vim.keymap.set("n", "gI", function() ose.telescope_lsp_implementation(Util.telescope.theme()) end, { desc = "Goto Implementation", buffer = 0 })
                        -- stylua: ignore end
                    end

                    local filetype = vim.bo[bufnr].filetype
                    if disable_semantic_tokens[filetype] then
                        client.server_capabilities.semanticTokensProvider = nil
                    end
                end,
            })
        end,
    },
}
