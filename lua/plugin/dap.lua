if not pcall(require, 'dap') then
  return
end

local should_reload = true
local reloader = function()
  if should_reload then
    RELOAD('plugin.dap')
  end
end

reloader()

-- Mappings
local mapper = function(mode, key, result)
	vim.api.nvim_set_keymap(mode, key, "<cmd>lua " .. result .. "<CR>", {noremap = true, silent = true})
end

mapper('n', '<leader>dd', [[require'dap'.continue()]]) 
mapper('n', '<leader>ds', [[require'dap'.stop()]]) 
mapper('n', '<leader>d<leader>', [[require'dap'.toggle_breakpoint()]]) 
mapper('n', '<leader>do', [[require'dap'.step_over()]]) 
mapper('n', '<leader>di', [[require'dap'.step_into()]]) 
mapper('n', '<leader>du', [[require'dap'.step_out()]]) 
mapper('n', '<leader>dr', [[require'dap'.repl.open()]]) 

-- Highlights
vim.fn.sign_define('DapBreakpoint', {text='', texthl='Error', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text='', texthl='Debug', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='', texthl='SignColumn', linehl='', numhl=''})


-- Adapter Configuration
local dap = require('dap')

-- Remove all breakpoints
dap.defaults.fallback.exception_breakpoints = {'raised'}

-- PHP Adapter
dap.adapters.php = {
	type = 'executable',
	command = 'node',
	args = {os.getenv('HOME') .. '/.local/dev/vscode-php-debug/out/phpDebug.js'},
}
dap.configurations.php = {
	{
		type = 'php',
		request = 'launch',
		name = 'PHP XDebug - Launch Adapter',
		port = 9003,
		protocol = 'inspector',
		console = 'integratedTerminal',
	},
	{
		type = 'php',
		request = 'launch',
		name = 'PHP XDebug - Launch File',
		port = 9003,
		program = '${file}',
		cwd = vim.fn.getcwd(),
		protocol = 'inspector',
		console = 'integratedTerminal',
	},
}

-- Javascript Adapter
dap.adapters.node2 = {
	type = 'executable',
	command = 'node',
	args = {os.getenv('HOME') .. '/.local/dev/vscode-node-debug2/out/src/nodeDebug.js'},
}
dap.configurations.javascript = {
	{
		type = 'node2',
		request = 'launch',
		program = '${file}',
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = 'inspector',
		console = 'integratedTerminal',
	},
}
