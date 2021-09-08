-- Colours, Themes and Fonts
-- vim.g.material_style = 'palenight'
-- vim.g.material_italic_comments = true
-- vim.g.material_italic_keywords = true
-- vim.g.material_italic_functions = true
-- vim.g.material_italic_variables = false
-- vim.g.material_contrast = true
-- vim.g.material_borders = true

-- require'material'.set()

vim.g.tokyonight_style = "storm"
vim.g.tokyonight_sidebars = {"qf", "vista_kind", "terminal", "packer", "NvimTree", "Outline"}
vim.cmd[[colorscheme tokyonight]]

-- local nightfox = require('nightfox')

-- -- This function set the configuration of nightfox. If a value is not passed in the setup function
-- -- it will be taken from the default configuration above
-- nightfox.setup({
--   fox = "nightfox",
--   styles = {
--     comments = "italic", -- change style of comments to be italic
--     keywords = "bold", -- change style of keywords to be bold
--     functions = "italic,bold" -- styles can be a comma separated list
--   },
--   colors = {},
--   hlgroup = {}
-- })

-- -- Load the configuration set above and apply the colorscheme
-- nightfox.load()
