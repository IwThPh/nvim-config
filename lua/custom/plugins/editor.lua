return {
    -- "gc" to comment visual regions/lines
    { "numToStr/Comment.nvim", opts = {} },
    { -- buffer remove
        "echasnovski/mini.bufremove",

        keys = {
            -- stylua: ignore start
            { "<leader>bd", function() require("mini.bufremove").delete(0) end,       desc = "Delete Buffer" },
            { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
            -- stylua: ignore end
        },
    },

    {
        "folke/zen-mode.nvim",
        keys = {
            -- stylua: ignore
            { "<leader>uz", function() require("zen-mode").toggle() end, desc = "Toggle Zenmode" },
        },
        opts = {
            window = {
                options = {
                    signcolumn = "no", -- disable signcolumn
                    number = false, -- disable number column
                    relativenumber = false, -- disable relative numbers
                    cursorline = false, -- disable cursorline
                    cursorcolumn = false, -- disable cursor column
                    foldcolumn = "0", -- disable fold column
                    list = false, -- disable whitespace characters
                },
            },
            plugins = {
                options = {
                    laststatus = 0, -- turn off the statusline in zen mode
                },
                gitsigns = { enabled = false }, -- disables git signs
                kitty = {
                    -- this will change the font size on kitty when in zen mode
                    -- to make this work, you need to set the following kitty options:
                    -- - allow_remote_control socket-only
                    -- - listen_on unix:/tmp/kitty
                    enabled = true,
                    font = "+4", -- font size increment
                },
                alacritty = {
                    enabled = true,
                    font = "18", -- font size
                },
            },
            -- callback where you can add custom code when the Zen window opens
            on_open = function(win)
                vim.cmd("IBLDisable")
                vim.opt.linebreak = true
            end,
            -- callback where you can add custom code when the Zen window closes
            on_close = function()
                vim.cmd("IBLEnable")
                vim.opt.linebreak = false
            end,
        },
    },
}
