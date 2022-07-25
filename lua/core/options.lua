local opt = vim.opt
local g = vim.g
local config = require("core.utils").load_config()

g.theme = config.ui.theme
g.transparency = config.ui.transparency

-- use filetype.lua instead of filetype.vim
-- g.did_load_filetypes = 0
-- g.do_filetype_lua = 1

opt.cmdheight = 1 -- Cannot use 0 which whichkey
opt.laststatus = 3 -- global statusline
opt.showmode = false
opt.colorcolumn = "0"
opt.cursorline = false

opt.title = true

-- Indenting
opt.expandtab = false
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.scrolloff = 7
opt.spelllang = "en_gb"
opt.langmenu = "en"
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

g.mapleader = " "

-- disable some builtin vim plugins
local default_plugins = {
   "2html_plugin",
   "getscript",
   "getscriptPlugin",
   "gzip",
   "logipat",
   "netrw",
   "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   "matchit",
   "tar",
   "tarPlugin",
   "rrhelper",
   "spellfile_plugin",
   "vimball",
   "vimballPlugin",
   "zip",
   "zipPlugin",
   "python3_provider",
   "python_provider",
   "node_provider",
   "ruby_provider",
   "perl_provider",
   "tutor",
   "rplugin",
   "syntax",
   "synmenu",
   "optwin",
   "compiler",
   "bugreport",
   "ftplugin",
}

for _, plugin in pairs(default_plugins) do
   g["loaded_" .. plugin] = 1
end

-- TODO: Find out what this does
-- set shada path
-- vim.schedule(function()
--    vim.opt.shadafile = vim.fn.expand "$HOME" .. "/.local/share/nvim/shada/main.shada"
--    vim.cmd [[ silent! rsh ]]
-- end)

opt.termguicolors = true
opt.lazyredraw = true
opt.magic = true
