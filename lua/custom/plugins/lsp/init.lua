return {
    -- lspconfig
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "mason.nvim" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason-lspconfig.nvim" },
            { "folke/neodev.nvim", opts = {} },
            { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
        },
        ---@class PluginLspOpts
        opts = {
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    prefix = "icons",
                },
                severity_sort = true,
            },
            -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
            -- Be aware that you also will need to properly configure your LSP server to
            -- provide the inlay hints.
            inlay_hints = {
                enabled = false,
            },
            -- add any global capabilities here
            capabilities = {},
            -- options for vim.lsp.buf.format
            -- `bufnr` and `filter` is handled by the LazyVim formatter,
            -- but can be also overridden when specified
            format = {
                formatting_options = nil,
                timeout_ms = nil,
            },
            -- LSP Server Settings
            ---@type lspconfig.options
            servers = {
                rust_analyzer = {},
                intelephense = {
                    init_options = { licenceKey = vim.fn.expand("~/.config/intelephense/licence.txt") },
                    settings = {
                        intelephense = { enviroment = { phpVersion = "8.1.*" } },
                    },
                },
                volar = {
                    init_options = {
                        typescript = {
                            serverPath = vim.fn.expand(
                                "~/.local/share/nvim/lsp_servers/tsserver/node_modules/typescript/lib/tsserverlibrary.js"
                            ),
                        },
                    },
                },
                tsserver = {
                    filetypes = {
                        "javascript",
                        "javascriptreact",
                        "javascript.jsx",
                        "typescript",
                        "typescriptreact",
                        "typescript.tsx",
                        "vue",
                    },
                },
                jsonls = {},
                html = {
                    filetypes = { "html", "templ", "blade" },
                    init_options = {
                        configurationSection = { "html", "css", "javascript" },
                        embeddedLanguages = {
                            css = true,
                            javascript = true,
                        },
                        provideFormatter = true,
                    },
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = { version = "LuaJIT" },
                            workspace = {
                                checkThirdParty = false,
                                -- Tells lua_ls where to find all the Lua files that you have loaded
                                -- for your neovim configuration.
                                library = {
                                    "${3rd}/luv/library",
                                    unpack(vim.api.nvim_get_runtime_file("", true)),
                                },
                                -- If lua_ls is really slow on your computer, you can try this instead:
                                -- library = { vim.env.VIMRUNTIME },
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                            diagnostics = { disable = { "missing-fields" } },
                        },
                    },
                },
            },
            -- you can do any additional lsp server setup here
            -- return true if you don't want this server to be setup with lspconfig
            ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
            setup = {
                volar = function(server, opts)
                    local Util = require("custom.util")
                    local lspconfig_util = require("lspconfig.util")
                    local function get_typescript_server_path(root_dir)
                        local global_ts = "~/.local/share/nvim/lsp_servers/tsserver/node_modules/typescript/lib"
                        -- Alternative location if installed as root:
                        -- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
                        local found_ts = ""
                        local function check_dir(path)
                            found_ts = lspconfig_util.path.join(path, "node_modules", "typescript", "lib")
                            if lspconfig_util.path.exists(found_ts) then
                                return path
                            end
                        end
                        if lspconfig_util.search_ancestors(root_dir, check_dir) then
                            return found_ts
                        else
                            return global_ts
                        end
                    end

                    require("lspconfig")[server].setup(Util.merge(opts, {
                        on_new_config = function(new_config, new_root_dir)
                            new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
                        end,
                    }))

                    return true
                end,
            },
        },
        ---@param opts PluginLspOpts
        config = function(_, opts)
            local Util = require("custom.util")

            if Util.has("neoconf.nvim") then
                local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
                require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
            end

            -- -- setup autoformat
            Util.format.register(Util.lsp.formatter())

            -- setup keymaps
            Util.lsp.on_attach(function(client, buffer)
                require("custom.plugins.lsp.keymaps").on_attach(client, buffer)
            end)

            local register_capability = vim.lsp.handlers["client/registerCapability"]

            vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
                local ret = register_capability(err, res, ctx)
                local client_id = ctx.client_id
                ---@type lsp.Client
                local client = vim.lsp.get_client_by_id(client_id)
                local buffer = vim.api.nvim_get_current_buf()
                require("custom.plugins.lsp.keymaps").on_attach(client, buffer)
                return ret
            end

            -- diagnostics
            for name, icon in pairs(require("custom.util.icons").diagnostics) do
                name = "DiagnosticSign" .. name
                vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
            end

            if opts.inlay_hints.enabled then
                Util.lsp.on_attach(function(client, buffer)
                    if client.supports_method("textDocument/inlayHint") then
                        Util.toggle.inlay_hints(buffer, true)
                    end
                end)
            end

            if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
                opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
                    or function(diagnostic)
                        local icons = require("custom.util.icons").diagnostics
                        for d, icon in pairs(icons) do
                            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                                return icon .. "⎸"
                            end
                        end
                    end
            end

            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

            local servers = opts.servers
            local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                has_cmp and cmp_nvim_lsp.default_capabilities() or {},
                opts.capabilities or {}
            )

            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                }, servers[server] or {})

                if opts.setup[server] then
                    if opts.setup[server](server, server_opts) then
                        return
                    end
                elseif opts.setup["*"] then
                    if opts.setup["*"](server, server_opts) then
                        return
                    end
                end
                require("lspconfig")[server].setup(server_opts)
            end

            -- get all the servers that are available through mason-lspconfig
            local have_mason, mlsp = pcall(require, "mason-lspconfig")
            local all_mslp_servers = {}
            if have_mason then
                all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
            end

            local ensure_installed = {} ---@type string[]
            for server, server_opts in pairs(servers) do
                if server_opts then
                    server_opts = server_opts == true and {} or server_opts
                    -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                    if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
                        setup(server)
                    else
                        ensure_installed[#ensure_installed + 1] = server
                    end
                end
            end

            if have_mason then
                mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
            end
        end,
    },

    { -- cmdline tools and lsp servers
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        build = ":MasonUpdate",
        opts = {
            ensure_installed = {
                "stylua",
                "shfmt",
                -- "flake8",
            },
        },
        ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")

            mr:on("package:install:success", function()
                vim.defer_fn(function()
                    -- trigger FileType event to possibly load this newly installed LSP server
                    require("lazy.core.handler.event").trigger({
                        event = "FileType",
                        buf = vim.api.nvim_get_current_buf(),
                    })
                end, 100)
            end)

            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },

    { -- show lightbulb for code actions
        "kosayoda/nvim-lightbulb",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvim-lightbulb").setup({
                autocmd = { enabled = true, updatetime = 100 },
                sign = { enabled = true, text = " " },
                line = { enabled = true },
                number = { enabled = true },
            })
        end,
    },
}
