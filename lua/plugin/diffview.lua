-- Lua
local cb = require'diffview.config'.diffview_callback

require'diffview'.setup {
	diff_binaries = false,    -- Show diffs for binaries
	file_panel = {
		width = 40,
		use_icons = true        -- Requires nvim-web-devicons
	},
}
