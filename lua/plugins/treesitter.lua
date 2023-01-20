local M = {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependacies = {
        'JoosepAlviste/nvim-ts-context-commentstring',
    },
}

function M.config()
    local treesitter = require('nvim-treesitter.configs')

    local options = {
        ensure_installed = 'all',
        highlight = {
            enable = true,
            use_languagetree = true,
            disable = { 'Neotree', 'NvimTree' },
        },
        indent = {
            enable = true,
        },
        context_commentstring = {
            enable = true,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<CR>',
                node_incremental = '<CR>',
                scope_incremental = '<S-CR>',
                node_decremental = '<BS>',
            },
        },
    }

    treesitter.setup(options)
end

return M
