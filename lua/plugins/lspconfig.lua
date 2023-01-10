local M = {
    'neovim/nvim-lspconfig',
    name = 'lspconfig',
    event = 'BufReadPre',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'SmiteshP/nvim-navic',
        'b0o/schemastore.nvim',
        'weilbith/nvim-code-action-menu',
    },
}

local function setupMason()
    require('mason').setup({

        ui = {
            icons = {
                server_installed = ' ',
                server_pending = ' ',
                server_uninstalled = ' ﮊ',
            },
            keymaps = {
                toggle_server_expand = '<CR>',
                install_server = 'i',
                update_server = 'u',
                check_server_version = 'c',
                update_all_servers = 'U',
                check_outdated_servers = 'C',
                uninstall_server = 'X',
            },
        },
        max_concurrent_installers = 10,
    })
    require('mason-lspconfig').setup({
        automatic_installation = true,
    })
end

function M.config()
    setupMason()

    local lspconfig = require('lspconfig')
    local navic = require('nvim-navic')
    require('ui.lsp')

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    local cmpNvimPresent, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
    if cmpNvimPresent then
        capabilities = cmp_nvim_lsp.default_capabilities()
    end

    capabilities.textDocument.completion.completionItem = {
        documentationFormat = { 'markdown', 'plaintext' },
        snippetSupport = true,
        preselectSupport = true,
        insertReplaceSupport = true,
        labelDetailsSupport = true,
        deprecatedSupport = true,
        commitCharactersSupport = true,
        tagSupport = { valueSet = { 1 } },
        resolveSupport = {
            properties = {
                'documentation',
                'detail',
                'additionalTextEdits',
            },
        },
    }

    -- capabilities for nvim-ufo folding
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }

    local ts_serverpath =
        vim.fn.expand('~/.local/share/nvim/lsp_servers/tsserver/node_modules/typescript/lib/tsserverlibrary.js')

    local servers = {
        bashls = true,
        cssls = false,
        dockerls = true,
        emmet_ls = true,
        eslint = true,
        graphql = true,
        html = true,
        intelephense = {
            init_options = { licenceKey = vim.fn.expand('~/.config/intelephense/licence.txt') },
            settings = {
                intelephense = {
                    enviroment = { phpVersion = '7.4.*' },
                    phpdoc = {
                        propertyTemplate = {
                            summary = '$1',
                            tags = { '@var ${2:$SYMBOL_TYPE}' },
                        },
                        functionTemplate = {
                            summary = '$SYMBOL_NAME',
                            description = '${1}',
                            tags = {
                                '@param ${1:$SYMBOL_TYPE} $SYMBOL_NAME $2',
                                '@return ${1:$SYMBOL_TYPE} $2',
                                '@throws ${1:$SYMBOL_TYPE} $2',
                            },
                        },
                        classTemplate = {
                            summary = '$1',
                            tags = {
                                '@package ${1:$SYMBOL_NAMESPACE}',
                            },
                        },
                    },
                },
            },
        },
        phpactor = false,
        jsonls = true,
        rust_analyzer = true,
        sqlls = {
            cmd = { 'sql-language-server', 'up', '--method', 'stdio' },
            settings = {
                cmd = { 'sql-language-server', 'up', '--method', 'stdio' },
            },
        },
        sumneko_lua = {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                        },
                        maxPreload = 100000,
                        preloadFileSize = 10000,
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        },
        tailwindcss = true,
        terraformls = true,
        -- tsserver = {
        -- 	cmd = { "typescript-language-server", "--stdio" },
        -- 	filetypes = {
        -- 		"javascript",
        -- 		"javascriptreact",
        -- 		"javascript.jsx",
        -- 		"typescript",
        -- 		"typescriptreact",
        -- 		"typescript.tsx",
        -- 	},
        -- 	on_attach = on_attach,
        -- },
        volar = {
            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
            init_options = {
                typescript = {
                    serverPath = ts_serverpath,
                },
            },
            settings = {
                languageFeatures = {
                    -- not supported - https://github.com/neovim/neovim/pull/14122
                    semanticTokens = false,
                    references = true,
                    definition = true,
                    typeDefinition = true,
                    callHierarchy = true,
                    hover = true,
                    rename = true,
                    renameFileRefactoring = true,
                    signatureHelp = true,
                    codeAction = true,
                    completion = {
                        defaultTagNameCase = 'both',
                        defaultAttrNameCase = 'kebabCase',
                    },
                    schemaRequestService = true,
                    documentHighlight = true,
                    documentLink = true,
                    codeLens = true,
                    diagnostics = true,
                },
                documentFeatures = {
                    -- not supported - https://github.com/neovim/neovim/pull/13654
                    documentColor = false,
                    selectionRange = true,
                    foldingRange = true,
                    linkedEditingRange = true,
                    documentSymbol = false, -- Not using up to date spec... will make pr
                    documentFormatting = {
                        defaultPrintWidth = 100,
                    },
                },
            },
        },
        volar_api = false,
        volar_doc = false,
        volar_html = false,
        yamlls = false,
        zk = true,
    }

    local setup_server = function(server, config)
        if not config then
            return
        end

        if type(config) ~= 'table' then
            config = {}
        end

        config = vim.tbl_deep_extend('force', {
            on_attach = function(client, bufnr)
                -- Rely on null-ls
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false

                require('core.mappings').lsp_mappings({ buffer = bufnr })

                if client.server_capabilities.documentSymbolProvider then
                    navic.attach(client, bufnr)
                end
            end,
            capabilities = capabilities,
        }, config)

        lspconfig[server].setup(config)
    end

    for server, config in pairs(servers) do
        setup_server(server, config)
    end
end

return M
