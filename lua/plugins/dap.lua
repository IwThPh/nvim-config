local masonPath = vim.fn.stdpath("data") .. "/mason/bin/"

return {
  -- Ensure php debug adapter is installed
  {
    "mason-nvim-dap.nvim",
    opts = {
      ensure_installed = { "php" },
    },
  },

  -- Modify nvim-dap
  {
    "mfussenegger/nvim-dap",

    config = function()
      local Config = require("lazyvim.config")
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(Config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end
      -- Default lazyvim config above, TODO: figure out how to remove this

      local dap = require("dap")

      -- PHP Adapters
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

      -- C# Adapters
      dap.adapters.coreclr = {
        type = "executable",
        command = "/usr/local/bin/netcoredbg/netcoredbg",
        args = { "--interpreter=vscode" },
      }

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
          end,
        },
      }
    end,
  },
}
