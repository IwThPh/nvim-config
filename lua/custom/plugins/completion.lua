return {
    {
        "hrsh7th/nvim-cmp",
        lazy = false,
        priority = 100,
        dependencies = {
            "onsails/lspkind.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
            "saadparwaiz1/cmp_luasnip",
            "roobert/tailwindcss-colorizer-cmp.nvim",
            "rafamadriz/friendly-snippets",
            "zbirenbaum/copilot.lua",
            "zbirenbaum/copilot-cmp",
        },
        config = function()
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
            })

            require("copilot_cmp").setup()

            require("custom.completion")
        end,
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
            },
        },
    },
    {
        "chrisgrieser/nvim-scissors",
        dependencies = "nvim-telescope/telescope.nvim",
        opts = {
            snippetDir = vim.fn.stdpath("config") .. "/snippets/",
            editSnippetPopup = { border = "single" },
        },
        keys = {
            -- stylua: ignore start
            { "<leader>cse", function() require("scissors").editSnippet() end, mode = { "n" }, desc = "Edit snippet" },
            { "<leader>csa", function() require("scissors").addNewSnippet() end, mode = { "n", "v" }, desc = "Add new snippet" },
            -- stylua: ignore end
        },
    },
}
