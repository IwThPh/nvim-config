local M = {
	"windwp/nvim-autopairs",
	name = "autopairs",
	dependencies = {
	"hrsh7th/nvim-cmp",
}
}

function M.config()
	local autopairs = require("nvim-autopairs")
	local cmp = require("cmp")

	autopairs.setup({
		fast_wrap = {},
		disable_filetype = { "TelescopePrompt", "vim" },
	})

	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
