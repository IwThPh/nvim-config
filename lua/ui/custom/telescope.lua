local palette = require('ui.theme').get_palette()

return {
    TelescopeBorder = {
        fg = palette.white.base,
    },

    TelescopePromptNormal = {
        fg = palette.white.base,
    },

    TelescopePromptPrefix = {
        fg = palette.red.base,
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
        fg = palette.bg2,
        bg = palette.white.base,
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
