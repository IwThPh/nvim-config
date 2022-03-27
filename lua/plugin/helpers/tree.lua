local nvimtree = require("nvim-tree")
local barbarstate = require("bufferline.state")
local tree = {}

tree.isOpen = false

tree.open = function()
	tree.isOpen = true
	barbarstate.set_offset(41, "FileTree")
	nvimtree.open()
	nvimtree.find_file(true)
end

tree.close = function()
	tree.isOpen = false
	barbarstate.set_offset(0)
	nvimtree.toggle() -- no close action...
end

tree.toggle = function()
	if tree.isOpen then
		tree.close()
	else
		tree.open()
	end
end

return tree
