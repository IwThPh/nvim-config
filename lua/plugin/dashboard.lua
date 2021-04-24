vim.g.dashboard_default_executive = 'telescope'

vim.g.dashboard_custom_header = {
	'   ██████╗ ███████╗██╗   ██╗',
	'   ██╔══██╗██╔════╝██║   ██║',
	'   ██║  ██║█████╗  ██║   ██║',
	'   ██║  ██║██╔══╝  ╚██╗ ██╔╝',
	'██╗██████╔╝███████╗ ╚████╔╝ ',
	'╚═╝╚═════╝ ╚══════╝  ╚═══╝  '
}

vim.g.dashboard_custom_section = {
	    a = {description = {'  Find File          '}, command = 'Telescope find_files'},
		b = {description = {'  Recently Used Files'}, command = 'Telescope oldfiles'},
		c = {description = {'  Load Last Session  '}, command = 'SessionLoad'},
		d = {description = {'  Live Grep          '}, command = 'Telescope live_grep'},
		e = {description = {'  Colourscheme       '}, command = 'Telescope colorscheme'},
		f = {description = {'  Settings           '}, command = ':e ~/.config/nvim/init.lua'}
}

 vim.g.dashboard_custom_footer = {'You make your own luck.'}

