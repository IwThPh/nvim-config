return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now

    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-telescope/telescope-smart-history.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
    },

    config = function()
        require("custom.telescope").setup()
    end,
}
