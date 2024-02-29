---@class custom.util.ui
local M = {}

---@alias Sign {name:string, text:string, texthl:string, priority:number}

-- Returns a list of regular and extmark signs sorted by priority (low to high)
---@return Sign[]
---@param buf number
---@param lnum number
function M.get_signs(buf, lnum)
    -- Get regular signs
    ---@type Sign[]
    local signs = {}

    if vim.fn.has("nvim-0.10") == 0 then
        -- Only needed for Neovim <0.10
        -- Newer versions include legacy signs in nvim_buf_get_extmarks
        for _, sign in ipairs(vim.fn.sign_getplaced(buf, { group = "*", lnum = lnum })[1].signs) do
            local ret = vim.fn.sign_getdefined(sign.name)[1] --[[@as Sign]]
            if ret then
                ret.priority = sign.priority
                signs[#signs + 1] = ret
            end
        end
    end

    -- Get extmark signs
    local extmarks = vim.api.nvim_buf_get_extmarks(
        buf,
        -1,
        { lnum - 1, 0 },
        { lnum - 1, -1 },
        { details = true, type = "sign" }
    )
    for _, extmark in pairs(extmarks) do
        signs[#signs + 1] = {
            name = extmark[4].sign_hl_group or "",
            text = extmark[4].sign_text,
            texthl = extmark[4].sign_hl_group,
            priority = extmark[4].priority,
        }
    end

    -- Sort by priority
    table.sort(signs, function(a, b)
        return (a.priority or 0) < (b.priority or 0)
    end)

    return signs
end

---@return Sign?
---@param buf number
---@param lnum number
function M.get_mark(buf, lnum)
    local marks = vim.fn.getmarklist(buf)
    vim.list_extend(marks, vim.fn.getmarklist())
    for _, mark in ipairs(marks) do
        if mark.pos[1] == buf and mark.pos[2] == lnum and mark.mark:match("[a-zA-Z]") then
            return { text = mark.mark:sub(2), texthl = "DiagnosticHint" }
        end
    end
end

---@param sign? Sign
---@param len? number
function M.icon(sign, len)
    sign = sign or {}
    len = len or 2
    local text = vim.fn.strcharpart(sign.text or "", 0, len) ---@type string
    text = text .. string.rep(" ", len - vim.fn.strchars(text))
    return sign.texthl and ("%#" .. sign.texthl .. "#" .. text .. "%*") or text
end

function M.fg(name)
    ---@type {foreground?:number}?
    ---@diagnostic disable-next-line: deprecated
    local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name })
        or vim.api.nvim_get_hl_by_name(name, true)
    ---@diagnostic disable-next-line: undefined-field
    local fg = hl and (hl.fg or hl.foreground)
    return fg and { fg = string.format("#%06x", fg) } or nil
end

return M
