local M = {
    'tpope/vim-projectionist',
}

function M.config()
    vim.keymap.set('n', ']r', '<cmd> A <CR>')

    vim.g.projectionist_heuristics = {
        ['app/|tests/'] = {
            ['app/*.php'] = { alternate = 'tests/Unit/{}Test.php' },
            ['tests/Unit/*Test.php'] = { alternate = 'app/{}.php' },
        },
    }
end

return M
