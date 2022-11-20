local present, mason = pcall(require, "mason")

if not present then
	return
end

local options = {
	ui = {
		icons = {
			server_installed = " ",
			server_pending = " ",
			server_uninstalled = " ﮊ",
		},
		keymaps = {
			toggle_server_expand = "<CR>",
			install_server = "i",
			update_server = "u",
			check_server_version = "c",
			update_all_servers = "U",
			check_outdated_servers = "C",
			uninstall_server = "X",
		},
	},
	max_concurrent_installers = 10,
}

mason.setup(options)

local masonLspConfigPresent, masonLspConfig = pcall(require, "mason-lspconfig")

if not masonLspConfigPresent then
	return
end

masonLspConfig.setup({
	automatic_installation = true,
})
