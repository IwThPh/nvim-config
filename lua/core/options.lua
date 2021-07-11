local o  =  vim.opt

-- Appearance
o.cmdheight = 2
o.colorcolumn = '100'
o.cursorline = true
o.wrap = false
o.number = true
o.showmode = false
o.signcolumn = "yes"
o.termguicolors = true
o.laststatus = 2
o.showmatch = true
o.matchtime = 2

-- Backups
o.backup = false
o.writebackup = false
o.swapfile = false

-- Completion
o.completeopt = "menuone,noselect"
o.pumblend = 10
o.pumheight = 8

-- General
o.hidden = true
o.joinspaces = false
o.mouse = 'a'
o.scrolloff = 7
o.splitbelow = true
o.splitright = true
o.spelllang = 'en_gb'
o.langmenu='en'
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
o.inccommand = "nosplit"
o.ignorecase = true
o.smartcase = true
o.wildignore =  { ".git/*", "node_modules/*" }
o.wildignorecase = true
o.wildmode='list:longest,list:full'

-- Performance
o.lazyredraw = true

-- For regex
o.magic = true

o.whichwrap = o.whichwrap + '<,>,h,l'

-- Format options
o.formatoptions = o.formatoptions + {
	o = false,	-- O and o, don't continue comments.
	r = true,	-- Pressing enter continues comments.
}
