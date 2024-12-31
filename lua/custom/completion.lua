require("custom.snippets")

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

-- Add tailwindcss-colorizer-cmp as a formatting source
require("tailwindcss-colorizer-cmp").setup({
    color_square_width = 2,
})

local lspkind = require("lspkind")
lspkind.init({
    symbol_map = {
        Copilot = "",
    },
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

local kind_formatter = lspkind.cmp_format({
    mode = "symbol_text",
    menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
        gh_issues = "[issues]",
        tn = "[TabNine]",
        eruby = "[erb]",
    },
})

local cmp = require("cmp")

cmp.setup({
    sources = {
        {
            name = "lazydev",
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
        },
        { name = "copilot", priority = 100 },
        { name = "nvim_lsp" },
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
        fields = { "abbr", "kind", "menu" },
        expandable_indicator = true,
        format = function(entry, vim_item)
            -- Lspkind setup for icons
            vim_item = kind_formatter(entry, vim_item)

            -- Tailwind colorizer setup
            vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)

            return vim_item
        end,
    },

    -- Enable luasnip to handle snippet expansion for nvim-cmp
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },

    sorting = {
        priority_weight = 2,
        comparators = {
            require("copilot_cmp.comparators").prioritize,

            -- Below is the default comparitor list and order for nvim-cmp
            cmp.config.compare.offset,
            -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },

    window = {
        -- completion = cmp.config.window.bordered()
        -- documentation = cmp.config.window.bordered(),
    },
})
