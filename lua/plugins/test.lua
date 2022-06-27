local function set_keymap(...) vim.api.nvim_set_keymap(...) end

-- Mappings.
local opts = { noremap=true, silent=true }
set_keymap('n', 'tn', ':TestNearest<CR>', opts)
set_keymap('n', 'tf', ':TestFile<CR>', opts)
set_keymap('n', 'ta', ':TestSuite<CR>', opts)
set_keymap('n', 'tt', ':TestLast<CR>', opts)

vim.api.nvim_set_var("test#strategy", "neovim")
vim.api.nvim_set_var("test#neovim#term_position", "botright 10")
vim.api.nvim_set_var("test#php#runner", "phpunit")
vim.api.nvim_set_var("test#php#phpunit#executable", "./vendor/bin/phpunit")

