local Util = require("custom.util")
return {
    { -- Better `vim.notify()`
        "rcarriga/nvim-notify",
        keys = {
            {
                "<leader>un",
                function()
                    require("notify").dismiss({ silent = true, pending = true })
                end,
                desc = "Dismiss all Notifications",
            },
        },
        opts = {
            timeout = 3000,
            level = vim.log.levels.WARN,
            render = "compact",
            stages = "static",
            max_height = function()
                return math.floor(vim.o.lines * 0.5)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.5)
            end,

            on_open = function(win)
                local config = vim.api.nvim_win_get_config(win)
                config.border = "single"
                vim.api.nvim_win_set_config(win, config)
            end,
        },
        init = function()
            vim.notify = require("notify")
        end,
    },

    { -- better vim.ui
        "stevearc/dressing.nvim",
        lazy = true,
        config = function()
            require("dressing").setup({
                input = {
                    border = "solid",
                },
                select = {
                    border = "solid",
                    telescope = require("custom.telescope").theme({
                        layout_config = {
                            height = 0.25,
                        },
                    }),
                },
            })
        end,
        init = function()
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },

    { -- statusline
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus
            if vim.fn.argc(-1) > 0 then
                -- set an empty statusline till lualine loads
                vim.o.statusline = " "
            end
        end,
        opts = function()
            local lualine_require = require("lualine_require")
            lualine_require.require = require

            local icons = require("custom.util.icons")

            vim.o.laststatus = vim.g.lualine_laststatus

            return {
                options = {
                    theme = "auto",
                    globalstatus = true,
                    -- component_separators = { left = '', right = '' },
                    -- section_separators = { left = '', right = '' },
                    component_separators = "",
                    section_separators = "",
                    disabled_filetypes = { statusline = { "dashboard", "alpha" } },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = {
                        {
                            "diagnostics",
                            symbols = {
                                error = icons.diagnostics.Error,
                                warn = icons.diagnostics.Warn,
                                info = icons.diagnostics.Info,
                                hint = icons.diagnostics.Hint,
                            },
                        },
                        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                        { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
                        -- stylua: ignore
                    },
                    lualine_x = {
                        -- stylua: ignore
                        {
                          function() return "  " .. require("dap").status() end,
                          cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
                          color = Util.ui.fg("Debug"),
                        },
                        {
                            require("lazy.status").updates,
                            cond = require("lazy.status").has_updates,
                            color = Util.ui.fg("Special"),
                        },
                        {
                            "diff",
                            symbols = {
                                added = icons.git.added,
                                modified = icons.git.modified,
                                removed = icons.git.removed,
                            },
                        },
                    },
                    lualine_y = {
                        { "progress", separator = " ", padding = { left = 1, right = 0 } },
                        { "location", padding = { left = 0, right = 1 } },
                    },
                    lualine_z = {
                        -- function() return " " .. os.date("%R") end,
                    },
                },
                extensions = { "oil", "lazy" },
            }
        end,
    },

    { -- indent guides for Neovim
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        main = "ibl",
        opts = {
            indent = {
                char = "│",
            },
            exclude = {
                filetypes = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
            },
            scope = { enabled = false },
        },
    },

    { "folke/which-key.nvim", opts = {} },

    { "nvim-tree/nvim-web-devicons", lazy = true }, -- icons
    { "MunifTanjim/nui.nvim", lazy = true }, -- ui components

    { "Bekaboo/dropbar.nvim", event = "VeryLazy" },

    {
        "luukvbaal/statuscol.nvim",
        event = "VeryLazy",
        config = function()
            local sc = require("statuscol")
            local builtin = require("statuscol.builtin")

            sc.setup({
                ft_ignore = { "help", "vim", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "toggleterm" },
                relculright = true,
                segments = {
                    { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
                    { sign = { name = { ".*" }, namespace = { ".*" } }, click = "v:lua.ScSa" },
                    { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
                    { sign = { namespace = { "gitsigns" } }, click = "v:lua.ScSa" },
                },
            })
        end,
    },
}
