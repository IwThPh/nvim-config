---------------------------------------------------------------
-- 	IwanThomPhil | init.vim
---------------------------------------------------------------

-- Util
local source = function(file, base)
	if base == nil then base = '~/.config/nvim' end
	vim.cmd('source ' .. base .. file)
end

local api = vim.api
local opt = vim.opt
local g = vim.g

-- General
require'config.globals'
require'config.plugins'
source'/general/settings.vim'
source'/keys/mappings.vim'

-- VIM user interface
opt.langmenu='en'
opt.wildmenu=true
opt.wildmode='list:longest,list:full'
opt.wildignore='*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store'

-- Colours, Themes and Fonts
g.material_style = 'palenight'
g.material_italic_comments = true
g.material_italic_keywords = true
g.material_italic_functions = true
g.material_italic_variables = false
g.material_contrast = true
g.material_borders = true
require'material'.set()

api.nvim_set_keymap('n', '<C-m>', [[<Cmd>lua require('material.functions').toggle_style()<CR>]], { noremap = true, silent = true })

-- Work around for netrw | barbar bug
g.netrw_bufsettings = 'noma nomod nonu nowrap ro buflisted'

require'plugin.galaxyline'
require'plugin.colorizer'

-- Plugins
if g.vscode then
	source'/vscode/settings.vim'
else
	require'plugin.completion'
	require'plugin.lsp'
	require'plugin.barbar'
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

