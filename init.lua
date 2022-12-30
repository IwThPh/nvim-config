---------------------------------------------------------------
-- 	IwanThomPhil | init.vim
---------------------------------------------------------------

-- Initialise Lazy Nvim Package Manager
require("core.options")
require("core.lazy")

require("core.autocmds")
local mappings = require("core.mappings")
require("core.utils").load_mappings(mappings)

-- Load the configuration set above and apply the colorscheme
vim.cmd("colorscheme " .. vim.g.theme)
