local data = assert(vim.fn.stdpath("data")) --[[@as string]]

local theme = function(opts)
    return vim.tbl_deep_extend(
        "force",
        {},
        require("telescope.themes").get_ivy({
            winblend = 5,
            border = true,
            borderchars = {
                "z",
                prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
                results = { " " },
                preview = { " " },
            },

            layout_config = {
                height = 0.6,
            },
        }),
        opts or {}
    )
end
-- local builtin = function(opts)
--     local builtin = require("telescope.builtin")
--     local params = { builtin = builtin, opts = opts }
--     return function()
--         builtin = params.builtin
--         opts = params.opts
--     end
-- end

local setup = function()
    require("telescope").setup({
        defaults = {
            prompt_prefix = " ",
            selection_caret = " ",
            mappings = {
                n = {
                    ["<C-c>"] = function(...)
                        return require("telescope.actions").close(...)
                    end,
                    ["q"] = function(...)
                        return require("telescope.actions").close(...)
                    end,
                },
            },
        },
        extensions = {
            wrap_results = true,

            fzf = {},
            history = {
                path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
                limit = 100,
            },
            ["ui-select"] = {
                require("telescope.themes").get_dropdown({}),
            },
        },
    })

    vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "NormalFloat" })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "TelescopeNormal" })

    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "smart_history")
    pcall(require("telescope").load_extension, "ui-select")

    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>gf", function()
        builtin.git_files(theme())
    end, { desc = "Search [G]it [F]iles" })
    vim.keymap.set("n", "<leader>sh", function()
        builtin.help_tags(theme())
    end, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sg", function()
        builtin.live_grep(theme())
    end, { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>sd", function()
        builtin.diagnostics(theme())
    end, { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader><space>", function()
        builtin.find_files(theme())
    end, { desc = "Find files (root dir)" })
    vim.keymap.set("n", "<leader>fb", function()
        builtin.buffers(theme())
    end, { desc = "Find files (root dir)" })

    vim.keymap.set("n", "<leader>gc", function()
        builtin.git_commits(theme())
    end, { desc = "[G]it [C]ommits" })
    vim.keymap.set("n", "<leader>gs", function()
        builtin.git_status(theme())
    end, { desc = "[G]it [S]tatus" })

    vim.keymap.set("n", "<leader>ft", function()
        return builtin.git_files(theme({ cwd = vim.fn.expand("%:h") }))
    end, { desc = "Find files (current dir)" })

    vim.keymap.set("n", "<leader>sw", function()
        builtin.grep_string(theme())
    end, { desc = "Word (root dir)" })
    -- vim.keymap.set(
    --     "n",
    --     "<leader>uC",
    --     builtin.colorscheme({ enable_preview = true }),
    --     { desc = "Colorscheme with preview" }
    -- )
end

setup()

return {
    setup = setup,
    theme = theme,
}
