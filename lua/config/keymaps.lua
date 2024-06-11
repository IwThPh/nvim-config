local Util = require("custom.util")

local map = vim.keymap.set

map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")

-- Macos alt key remaps
map({ "n", "v" }, "˙", "<M-h>")
map({ "n", "v" }, "∆", "<M-j>")
map({ "n", "v" }, "˚", "<M-k>")
map({ "n", "v" }, "¬", "<M-l>")

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
    "n",
    "<leader>ur",
    "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { desc = "Redraw / clear hlsearch / diff update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add mapping for split window right with = instead of |
map("n", "<leader>w=", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>=", "<C-W>v", { desc = "Split window right" })

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- buffers
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- diagnostic
local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go({ severity = severity })
    end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

if vim.fn.executable("zellij") == 1 then
    local function zellijAction(opts)
        local Job = require("plenary.job")

        --stylua: ignore
        local args = { "run", "-f", "-c", "-x", "10%", "-y", "10%", "--width", "80%", "--height", "80%" }

        for _, v in ipairs(opts) do
            table.insert(args, v)
        end

        Job:new({
            command = "zellij",
            args = args,
        }):start()
    end

    map("n", "<leader>tf", function()
        zellijAction({ "-n", "shell", "--", "zsh" })
    end, { desc = "Launch [T]erminal [F]loating" })

    if vim.fn.executable("lazygit") == 1 then
        map("n", "<leader>tg", function()
            zellijAction({ "-n", "lazygit", "--", "lazygit" })
        end, { desc = "Launch [T]erminal [L]azygit" })
    end
end
