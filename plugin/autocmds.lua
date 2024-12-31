local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local bufcheck = augroup("bufcheck", { clear = true })

-- [[ Save on FocusLost ]]
autocmd("FocusLost", {
    group = bufcheck,
    command = "wa",
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

vim.filetype.add({
    extension = {
        ["http"] = "http",
    },
})
