local opt = vim.opt
local g = vim.g

g.theme = "terafox"

opt.cmdheight = 0
opt.laststatus = 3 -- global statusline
opt.showmode = false
opt.colorcolumn = "0"
opt.cursorline = false
opt.pumheight = 10

opt.shortmess:append "c" -- don't show redundant messages from ins-completion-menu
opt.shortmess:append "I" -- don't show the default intro message
opt.whichwrap:append "<,>,[,],h,l"

opt.completeopt = { "menuone", "noselect" }

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

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.scrolloff = 7
opt.spelllang = "en_gb"
opt.langmenu = "en"
opt.termguicolors = true
opt.timeoutlen = 1000
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

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

opt.termguicolors = true
opt.lazyredraw = true
opt.magic = true
