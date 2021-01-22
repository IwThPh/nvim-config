local chad_settings = {
	view = {
		width = 40;
	};
};

vim.api.nvim_set_var("chadtree_settings", chad_settings)

vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>CHADopen<CR>', { noremap = true, silent = true })

