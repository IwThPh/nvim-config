local present, dap = pcall(require, "dap")

if not present then
   return
end


-- mapper('n', '<leader>dd', [[require'dap'.continue()]])
-- mapper('n', '<leader>ds', [[require'dap'.stop()]])
-- mapper('n', '<leader>d<leader>', [[require'dap'.toggle_breakpoint()]])
-- mapper('n', '<leader>dc', [[require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))]])
-- mapper('n', '<leader>do', [[require'dap'.step_over()]])
-- mapper('n', '<leader>di', [[require'dap'.step_into()]])
-- mapper('n', '<leader>du', [[require'dap'.step_out()]])
-- mapper('n', '<leader>dr', [[require'dap'.repl.open()]])

-- Highlights
-- vim.fn.sign_define('DapBreakpoint', {text='', texthl='Error', linehl='', numhl=''})
-- vim.fn.sign_define('DapLogPoint', {text='', texthl='Debug', linehl='', numhl=''})
-- vim.fn.sign_define('DapStopped', {text='', texthl='SignColumn', linehl='', numhl=''})

-- REPL Completion
-- vim.api.nvim_command [[ au FileType dap-repl lua require('dap.ext.autocompl').attach() ]]

-- Remove all breakpoints
-- dap.defaults.fallback.exception_breakpoints = {'raised'}

-- PHP Adapter
-- dap.adapters.php = {
-- 	type = 'executable',
-- 	command = 'node',
-- 	args = {os.getenv('HOME') .. '/.local/dev/vscode-php-debug/out/phpDebug.js'},
-- }
-- dap.configurations.php = {
-- 	{
-- 		type = 'php',
-- 		request = 'launch',
-- 		name = 'PHP XDebug - Launch Adapter',
-- 		port = 9000,
-- 		protocol = 'inspector',
-- 		console = 'integratedTerminal',
-- 	},
-- 	{
-- 		type = 'php',
-- 		request = 'launch',
-- 		name = 'PHP XDebug - Launch File',
-- 		port = 9000,
-- 		program = '${file}',
-- 		cwd = vim.fn.getcwd(),
-- 		protocol = 'inspector',
-- 		console = 'integratedTerminal',
-- 	},
-- }

-- Javascript Adapter
-- dap.adapters.node2 = {
-- 	type = 'executable',
-- 	command = 'node',
-- 	args = {os.getenv('HOME') .. '/.local/dev/vscode-node-debug2/out/src/nodeDebug.js'},
-- }
-- dap.configurations.javascript = {
-- 	{
-- 		type = 'node2',
-- 		request = 'launch',
-- 		program = '${file}',
-- 		cwd = vim.fn.getcwd(),
-- 		sourceMaps = true,
-- 		protocol = 'inspector',
-- 		console = 'integratedTerminal',
-- 	},
-- }
