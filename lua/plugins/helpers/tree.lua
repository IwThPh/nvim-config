local barbarstate = require("bufferline.state")
local tree = {}

tree.isOpen = false


tree.open = function()
	local width = vim.api.nvim_get_option("columns")
	tree.isOpen = true
	barbarstate.set_offset(math.ceil(width * 1 / 5), "NeoTree")
	vim.cmd [[ Neotree reveal ]]
end

tree.close = function()
	tree.isOpen = false
	barbarstate.set_offset(0)
	vim.cmd [[ Neotree close ]]
end

tree.toggle = function()
	if tree.isOpen then
		tree.close()
	else
		tree.open()
	end
end

return tree
