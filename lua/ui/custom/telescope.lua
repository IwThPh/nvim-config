local palette = require("ui.theme").get_palette()

return {
   TelescopeBorder = {
      fg = palette.bg0,
      bg = palette.bg0,
   },

   TelescopePromptBorder = {
      fg = palette.bg2,
      bg = palette.bg2,
   },

   TelescopePromptNormal = {
      fg = palette.white.base,
      bg = palette.bg2,
   },

   TelescopePromptPrefix = {
      fg = palette.red.base,
      bg = palette.bg2,
   },

   TelescopeNormal = {
	   bg = palette.bg0,
   },

   TelescopePreviewTitle = {
      fg = palette.bg2,
      bg = palette.green.base,
   },

   TelescopePromptTitle = {
      fg = palette.bg2,
      bg = palette.red.base,
   },

   TelescopeResultsTitle = {
      fg = palette.bg0,
      bg = palette.bg0,
   },

   TelescopeSelection = {
	   fg = palette.white.base,
	   bg = palette.sel0,
   },

   TelescopeResultsDiffAdd = {
      fg = palette.green.base,
   },

   TelescopeResultsDiffChange = {
      fg = palette.yellow.base,
   },

   TelescopeResultsDiffDelete = {
      fg = palette.red.base,
   },
}
