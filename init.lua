---------------------------------------------------------------
-- 	IwanThomPhil | init.vim
---------------------------------------------------------------

-- Util
local source = function(file, base)
	if base == nil then base = '~/.config/nvim' end
	vim.cmd('source ' .. base .. file)
end

-- General
require'config.globals'
require'config.plugins'
source'/general/settings.vim'
source'/keys/mappings.vim'

-- VIM user interface
vim.api.nvim_command('set langmenu=en')
vim.api.nvim_command('set wildmenu')
vim.api.nvim_command('set wildmode=list:longest,list:full')
vim.api.nvim_command('set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store')

-- Colours, Themes and Fonts
vim.g.material_style = 'palenight'         
vim.g.material_italic_comments = true
vim.g.material_italic_keywords = true
vim.g.material_italic_functions = true
vim.g.material_italic_variables = false
vim.g.material_contrast = true
vim.g.material_borders = true 
require'material'.set()

vim.api.nvim_set_keymap('n', '<C-m>', [[<Cmd>lua require('material.functions').toggle_style()<CR>]], { noremap = true, silent = true })

-- Work around for netrw | barbar bug
vim.g.netrw_bufsettings = 'noma nomod nonu nowrap ro buflisted'

require'plugin.galaxyline'
require'plugin.colorizer'

-- Plugins
if vim.g.vscode then
	source'/vscode/settings.vim'
else
	require'plugin.completion'
	require'plugin.lsp'
	require'plugin.dashboard'
	require'plugin.truezen'
	require'plugin.telescope'
	require'plugin.telescope.mapping'
	require'plugin.test'
	require'plugin.dap'
	require'plugin.treesitter'
	require'plugin.nvimtree'
	require'plugin.gitsigns'
end

