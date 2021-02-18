require'bufferline'.setup{
	options = {
		view = "multiwindow", -- | "default",
		numbers = "none",  -- | "ordinal" | "buffer_id",
		number_style = "", -- "superscript" | ""
		-- mappings = true | false,
		buffer_close_icon= '',
		modified_icon = '●',
		close_icon = '',
		left_trunc_marker = '',
		right_trunc_marker = '',
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is deduplicated
		tab_size = 18,
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and " " or ""
		  	return "("..icon .. " " .. count..")"
		end,
		show_buffer_close_icons = false,
		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		-- can also be a table containing 2 custom separators
		-- [focused and unfocused]. eg: { '|', '|' }
		separator_style = "thick", -- | "thin" | { 'any', 'any' },
		enforce_regular_tabs = true,
		always_show_bufferline = true,
		sort_by = 'directory', -- 'extension' | 'relative_directory' | function(buffer_a, buffer_b)
		  -- -- add custom logic
		  -- return buffer_a.modified > buffer_b.modified
		-- end
	};
};
