require("custom.snippets")

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

-- vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

local lspkind = require("lspkind")

local cmp = require("cmp")

cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "copilot", priority = 100 },
        { name = "neorg" },

        { name = "path" },
        { name = "buffer" },
    },
    mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-y>"] = cmp.mapping(
            cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            }),
            { "i", "c" }
        ),
    },

    formatting = {
        format = lspkind.cmp_format({
            mode = "text_symbol",
            maxwidth = function()
                return math.floor(0.45 * vim.o.columns)
            end,
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default
        }),
    },

    -- Enable luasnip to handle snippet expansion for nvim-cmp
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
})

require("copilot_cmp").setup({})
