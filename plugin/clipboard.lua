local opt = vim.opt

opt.clipboard = "unnamedplus"

if vim.fn.has("wsl") == 1 then
    if vim.fn.executable("wl-copy") == 0 then
        print("wl-clipboard not found, clipboard integration won't work")
    else
        vim.g.clipboard = {
            name = "wl-clipboard (wsl)",
            copy = {
                ["+"] = "wl-copy --foreground --type text/plain",
                ["*"] = "wl-copy --foreground --primary --type text/plain",
            },
            paste = {
                ["+"] = function()
                    return vim.fn.systemlist('wl-paste --no-newline|sed -e "s/\r$//"', { "" }, 1) -- '1' keeps empty lines
                end,
                ["*"] = function()
                    return vim.fn.systemlist('wl-paste --primary --no-newline|sed -e "s/\r$//"', { "" }, 1)
                end,
            },
            cache_enabled = true,
        }
    end
end

if vim.env.SSH_CONNECTION then
    local function vim_paste()
        local content = vim.fn.getreg('"')
        return vim.split(content, "\n")
    end

    vim.g.clipboard = {
        name = "OSC 52",
        copy = {
            ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
            ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
        },
        paste = {
            ["+"] = vim_paste,
            ["*"] = vim_paste,
        },
    }
end
