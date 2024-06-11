return {
    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "▍" },
                change = { text = "▍" },
                delete = { text = "▂" },
                topdelete = { text = "🮂" },
                changedelete = { text = "▎" },
                untracked = { text = "︴" },
            },
            signcolumn = true,
            on_attach = function(bufnr)
                local gs = require("gitsigns")

                -- stylua: ignore start
                vim.keymap.set("n", "<leader>hp", gs.preview_hunk_inline, { buffer = bufnr, desc = "Preview git hunk" })
                vim.keymap.set("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame Line" })
                vim.keymap.set("n", "<leader>hd", gs.diffthis, { desc = "Diff This" })
                vim.keymap.set("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Diff This ~" })
                vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "Stage git hunk" })
                vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr, desc = "Restore git hunk" })
                vim.keymap.set("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { buffer = bufnr, desc = "Stage git hunk" })
                vim.keymap.set("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { buffer = bufnr, desc = "Restore git hunk" })
                -- stylua: ignore end

                -- don't override the built-in and fugitive keymaps
                local gs = package.loaded.gitsigns
                vim.keymap.set({ "n", "v" }, "]c", function()
                    if vim.wo.diff then
                        return "]c"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
                vim.keymap.set({ "n", "v" }, "[c", function()
                    if vim.wo.diff then
                        return "[c"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
            end,
        },
    },
}
