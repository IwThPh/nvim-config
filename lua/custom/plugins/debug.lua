-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
local masonPath = vim.fn.stdpath("data") .. "/mason/bin/"

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
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        "php",
      },
    })

    -- Hightlight the line that is currently being executed.
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Debug: Step Out" })
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dB", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Debug: Set Breakpoint" })
    vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Debug: Terminate" })
    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      controls = {
        icons = {
          pause = "⏸",
          play = "▶",
          step_into = "⏎",
          step_over = "⏭",
          step_out = "⏮",
          step_back = "b",
          run_last = "▶▶",
          terminate = "⏹",
          disconnect = "⏏",
        },
      },
    })

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    dap.adapters.php = function(callback, config)
      callback({
        type = "executable",
        command = masonPath .. "php-debug-adapter",
      })
    end

    dap.configurations.php = {
      {
        type = "php",
        request = "launch",
        name = "Listen for Xdebug",
        pathMappings = {
          ["/var/www/html"] = "${workspaceFolder}",
        },
      },
    }
  end,
}
