-- debug.lua
return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",

        -- Installs the debug adapters for you
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",

        -- virtual text for the debugger
        "theHamsta/nvim-dap-virtual-text",
    },

    config = function()
        require("custom.debug")
    end,
}
