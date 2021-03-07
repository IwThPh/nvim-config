local chad_settings = {
	theme = {
		text_colour_set = "nerdtree_syntax_dark";
	};
	view = {
		width = 40;
	};
};

vim.api.nvim_set_var("chadtree_settings", chad_settings)

vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>CHADopen<CR>', { noremap = true, silent = true })

