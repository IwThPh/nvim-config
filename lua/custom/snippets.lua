local ls = require("luasnip")

-- TODO: Think about `locally_jumpable`, etc.
-- Might be nice to send PR to luasnip to use filters instead for these functions ;)

vim.snippet.expand = ls.lsp_expand

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.active = function(filter)
    filter = filter or {}
    filter.direction = filter.direction or 1

    if filter.direction == 1 then
        return ls.expand_or_jumpable()
    else
        return ls.jumpable(filter.direction)
    end
end

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.jump = function(direction)
    if direction == 1 then
        if ls.expandable() then
            return ls.expand_or_jump()
        else
            return ls.jumpable(1) and ls.jump(1)
        end
    else
        return ls.jumpable(-1) and ls.jump(-1)
    end
end

vim.snippet.stop = ls.unlink_current

-- ================================================
ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    override_builtin = true,
})

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({
    paths = { "~/.config/nvim/snippets/php" },
})

-- TODO: consider lua dir
for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("snippets/*.lua", true)) do
    loadfile(ft_path)()
end

-- TODO: consider <c-j> and <c-k> for jumping
vim.keymap.set({ "i", "s" }, "<tab>", function()
    return vim.snippet.active({ direction = 1 }) and vim.snippet.jump(1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<s-tab>", function()
    return vim.snippet.active({ direction = -1 }) and vim.snippet.jump(-1)
end, { silent = true })
