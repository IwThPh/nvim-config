return {
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        lazy = true, -- specify lazy = false because some lazy.nvim distributions set lazy = true by default
        -- tag = "*",
        cmd = "Neorg",
        dependencies = { "nvim-lua/plenary.nvim" },
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
                                home = "~/notes",
                                personal = "~/notes/personal",
                                work = "~/notes/work",
                            },
                            default_workspace = "home",
                            -- TODO: add new note to subdir of workspace 00-inbox
                        },
                    },
                    ["core.journal"] = {
                        config = {
                            workspace = "home",
                            journal_folder = "journal",
                            use_folders = true,
                        },
                    },
                },
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
