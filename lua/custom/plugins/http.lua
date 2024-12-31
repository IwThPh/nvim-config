return {
    {
        "mistweaverco/kulala.nvim",
        opts = {},
        keys = {
            {
                "<leader>hr",
                function()
                    require("kulala").run()
                end,
                mode = { "n" },
                desc = "Execute HTTP request",
            },
            {
                "<leader>hi",
                function()
                    require("kulala").inspect()
                end,
                mode = { "n" },
                desc = "Inspect HTTP request",
            },
            {
                "<leader>hy",
                function()
                    require("kulala").copy()
                end,
                mode = { "n" },
                desc = "Copy HTTP request as cURL command",
            },
            {
                "<leader>hp",
                function()
                    require("kulala").from_curl()
                end,
                mode = { "n" },
                desc = "Paste HTTP request from clipboard (cURL)",
            },
            {
                "<leader>hh",
                function()
                    require("kulala").replay()
                end,
                mode = { "n" },
                desc = "Replay previous HTTP request",
            },
            {
                "<leader>h<cr>",
                function()
                    require("kulala").scratchpad()
                end,
                mode = { "n" },
                desc = "Open HTTP request scratchpad",
            },
        },
    },
}
