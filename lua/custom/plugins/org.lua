return {
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        lazy = true, -- specify lazy = false because some lazy.nvim distributions set lazy = true by default
        -- tag = "*",
        cmd = "Neorg",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "pysan3/neorg-templates", dependencies = { "L3MON4D3/LuaSnip" } },
        },
        -- stylua: ignore
        keys = {
            { "<leader>n<leader>", function() vim.cmd("Neorg index") end, desc = "[neorg] Workspace Index" },
            { "<leader>n<cr>", function() vim.cmd("Neorg return") end, desc = "[neorg] Return" },
            { "<leader>nh", function() vim.cmd("Neorg workspace home") end, desc = "[neorg] Home Workspace" },
            { "<leader>np", function() vim.cmd("Neorg workspace personal") end, desc = "[neorg] Personal Workspace" },
            { "<leader>nw", function() vim.cmd("Neorg workspace work") end, desc = "[neorg] Work Workspace" },
            { "<leader>nj", function() vim.cmd("Neorg journal") end, desc = "[neorg] Journel" },
        },
        config = function()
            local norg_dir = "~/notes/"

            require("neorg").setup({
                load = {
                    ["core.defaults"] = {}, -- Loads default behaviour
                    ["core.concealer"] = {
                        config = {
                            icon_preset = "diamond",
                        },
                    }, -- Adds pretty icons to your documents
                    ["core.completion"] = {
                        config = {
                            engine = "nvim-cmp",
                        },
                    },
                    ["core.presenter"] = {
                        config = {
                            zen_mode = "zen-mode",
                        },
                    },
                    ["core.dirman"] = { -- Manages Neorg workspaces
                        config = {
                            workspaces = {
                                home = norg_dir,
                                personal = norg_dir .. "personal",
                                work = norg_dir .. "work",
                            },
                            default_workspace = "home",
                            -- TODO: add new note to subdir of workspace 00-inbox
                        },
                    },
                    ["core.journal"] = {
                        config = {
                            workspace = "home",
                            journal_folder = "journal",
                            strategy = "flat", -- "nested" or "flat"
                            use_template = false, -- provided by neorg-templates
                        },
                    },
                    ["core.export"] = {}, -- Exports documents
                    ["core.export.markdown"] = {},
                    ["external.templates"] = {
                        config = {
                            templates_dir = vim.fn.stdpath("config") .. "/templates/norg",
                            -- default_subcommand = "add", -- or "fload", "load"
                            -- keywords = { -- Add your own keywords.
                            --   EXAMPLE_KEYWORD = function ()
                            --     return require("luasnip").insert_node(1, "default text blah blah")
                            --   end,
                            -- },
                            -- snippets_overwrite = {},
                        },
                    },
                },
            })

            local group = vim.api.nvim_create_augroup("NeorgLoadTemplateGroup", { clear = true })

            local is_buffer_empty = function(buffer)
                local content = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
                return not (#content > 1 or content[1] ~= "")
            end

            local callback = function(args)
                vim.schedule(function()
                    if not is_buffer_empty(args.buf) then
                        return
                    end

                    if string.find(args.file, "/journal/") then
                        -- debug('loading template "journal" ' .. args.event)
                        vim.api.nvim_cmd({ cmd = "Neorg", args = { "templates", "fload", "journal" } }, {})
                    else
                        -- debug("add metadata " .. args.event)
                        vim.api.nvim_cmd({ cmd = "Neorg", args = { "inject-metadata" } }, {})
                    end
                end)
            end

            vim.api.nvim_create_autocmd({ "BufNewFile", "BufNew" }, {
                desc = "Load template on new norg files",
                pattern = "*.norg",
                callback = callback,
                group = group,
            })
        end,
    },

    -- neorg cmp source
    {
        "nvim-cmp",
        dependencies = {
            "nvim-neorg/neorg",
        },
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
            table.insert(opts.sources, 1, { name = "neorg" })
        end,
    },
}
