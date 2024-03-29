local o = vim.opt

-- Appearance
o.cmdheight = 0
o.colorcolumn = "0"
o.cursorline = false
o.wrap = false
o.number = true
o.showmode = false
o.signcolumn = "yes"
o.termguicolors = true
o.laststatus = 3
o.showmatch = true
o.matchtime = 2

-- Backups
o.backup = false
o.writebackup = false
o.swapfile = false

-- Completion
o.completeopt = "menu,menuone,noinsert,noselect"
o.pumblend = 30
o.pumheight = 8

-- General
o.joinspaces = false
o.mouse = "a"
o.scrolloff = 7
o.splitbelow = true
o.splitright = true
o.spelllang = "en_gb"
o.langmenu = "en"
o.updatetime = 300
o.timeoutlen = 500

-- Text, tab and indent related
o.expandtab = false
o.shiftwidth = 4
o.tabstop = 4
o.smartindent = true

-- A buffer becomes hidden when it is abandoned
o.hid = true

-- Searching
o.ignorecase = true
o.smartcase = true
o.wildignore = { ".git/*", "node_modules/*" }
o.wildignorecase = true
o.wildmode = "list:longest,list:full"

-- Performance
o.lazyredraw = true

-- For regex
o.magic = true

o.whichwrap = o.whichwrap + "<,>,h,l"

-- Format options
-- Pressing enter continues comments.
-- o and O don't continue comments.
o.formatoptions = o.formatoptions + "r" - "o"
