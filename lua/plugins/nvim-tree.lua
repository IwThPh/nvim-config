local M = {
    'nvim-tree/nvim-tree.lua',
    name = 'nvim-tree',
    dependancies = {
        'nvim-tree/nvim-web-devicons',
    },
}

function M.config()
    require('nvim-tree').setup({
        sort_by = 'case_sensitive',
        view = {
            adaptive_size = true,
        },
        renderer = {
            group_empty = true,
        },
    })
end

return M
