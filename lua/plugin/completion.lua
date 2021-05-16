vim.api.nvim_set_option('completeopt', 'menu,menuone,noinsert,noselect')

require'compe'.setup {
	enabled = true;
  	autocomplete = true;
  	debug = false;
  	min_length = 1;
  	preselect = 'enable';
  	throttle_time = 80;
  	source_timeout = 200;
  	incomplete_delay = 400;
  	max_abbr_width = 100;
  	max_kind_width = 100;
  	max_menu_width = 100;
	documentation = true;

	source = {
		path = true;
		buffer = true;
		calc = true;
		nvim_lsp = true;
		nvim_lua = true;
		snippets_nvim = true;
	};
}

-- Mappings.
local function set_keymap(...) vim.api.nvim_set_keymap(...) end
local opts = { noremap=true, silent=true, expr=true }
set_keymap('i', '<C-Space>', 'compe#complete()', opts)
set_keymap('i', '<CR>', 'compe#confirm("<CR>")', opts)
set_keymap('i', '<C-e>', 'compe#close("<C-e>")', opts)

require'snippets'.use_suggested_mappings()
