local M = {
    'lukas-reineke/indent-blankline.nvim',
    name = 'blankline',
}

function M.config()
    require('ui.theme').load_highlight('blankline')
    require('indent_blankline').setup({
        use_treesitter = true,
        filetype_exclude = {
            'lazy',
            'help',
            'terminal',
            'lspinfo',
            'TelescopePrompt',
            'TelescopeResults',
            'lsp-installer',
            '',
        },
        char = '│',
        space_char_blankline = ' ',
        show_current_context = true,
        show_current_context_start = true,
        show_trailing_blankline_indent = false,
        buftype_exclude = { 'terminal' },
        show_first_indent_level = true,
    })
end

return M
