local M = {
    'lewis6991/gitsigns.nvim',
    name = 'gitsigns',
}

function M.config()
    require('gitsigns').setup({
        signs = {
            add = { text = '│' },
            change = { text = '│' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
            untracked = { text = '┆' },
        },
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
            delay = 500,
            ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    })
end

return M
