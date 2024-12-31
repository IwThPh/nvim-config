-- [[ Setting options ]]
-- See `:help vim.o`

local opt = vim.opt

-- Set highlight on search
vim.o.hlsearch = true

opt.mouse = "a"

opt.number = true

opt.inccommand = "split"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

opt.splitbelow = true
opt.splitright = true

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

opt.termguicolors = true

opt.wrap = true
opt.linebreak = true
opt.breakindent = true -- maintain indent when wrapping indented lines
opt.fillchars = { eob = " " }
opt.relativenumber = false
opt.expandtab = true

-- Don't have `o` add a comment
opt.formatoptions:remove("o")

opt.swapfile = false

opt.shiftwidth = 4
opt.tabstop = 4

opt.spelllang = { "en_gb" }
opt.whichwrap:append("<,>,[,],h,l")
opt.list = true
opt.listchars = { trail = "·", tab = "▸ " } -- eol = '↴',
opt.cmdheight = 0
opt.scrolloff = 7

opt.more = false
