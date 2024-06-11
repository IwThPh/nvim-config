-- Shows how to use the DAP plugin to debug your code.
local masonPath = vim.fn.stdpath("data") .. "/mason/bin/"

local dap = require("dap")
local dapui = require("dapui")

-- stylua: ignore start
vim.keymap.set("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = "Breakpoint Condition" })
vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "Continue" })
vim.keymap.set("n", "<leader>da", function() dap.continue({ before = get_args }) end, { desc = "Run with Args" })
vim.keymap.set("n", "<leader>dC", function() dap.run_to_cursor() end, { desc = "Run to Cursor" })
vim.keymap.set("n", "<leader>dg", function() dap.goto_() end, { desc = "Go to line (no execute)" })
vim.keymap.set("n", "<leader>di", function() dap.step_into() end, { desc = "Step Into" })
vim.keymap.set("n", "<leader>dj", function() dap.down() end, { desc = "Down" })
vim.keymap.set("n", "<leader>dk", function() dap.up() end, { desc = "Up" })
vim.keymap.set("n", "<leader>dl", function() dap.run_last() end, { desc = "Run Last" })
vim.keymap.set("n", "<leader>do", function() dap.step_out() end, { desc = "Step Out" })
vim.keymap.set("n", "<leader>dO", function() dap.step_over() end, { desc = "Step Over" })
vim.keymap.set("n", "<leader>dp", function() dap.pause() end, { desc = "Pause" })
vim.keymap.set("n", "<leader>dr", function() dap.repl.toggle() end, { desc = "Toggle REPL" })
vim.keymap.set("n", "<leader>ds", function() dap.session() end, { desc = "Session" })
vim.keymap.set("n", "<leader>dt", function() dap.terminate() end, { desc = "Terminate" })
vim.keymap.set("n", "<leader>dw", function() require("dap.ui.widgets").hover() end, { desc = "Widgets" })
vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, { desc = "Toggle DAP UI" })
-- stylua: ignore end

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
        "C#",
    },
})

-- Dap UI setup
-- For more information, see |:help nvim-dap-ui|
dapui.setup({
    icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
    -- controls = {
    --     icons = {
    --         pause = "⏸",
    --         play = "▶",
    --         step_into = "⏎",
    --         step_over = "⏭",
    --         step_out = "⏮",
    --         step_back = "␈",
    --         run_last = "▶▶",
    --         terminate = "⏹",
    --         disconnect = "⏏",
    --     },
    -- },
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

dap.adapters.netcoredbg = {
    type = "executable",
    command = "netcoredbg",
    args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
    {
        type = "netcoredbg",
        name = "launch - netcoredbg",
        request = "launch",
        env = "ASPNETCORE_ENVIRONMENT=Development",
        args = {
            "/p:EnvironmentName=Development", -- this is a msbuild jk
            --  this is set via environment variable ASPNETCORE_ENVIRONMENT=Development
            "--urls=http://localhost:5002",
            "--environment=Development",
        },
        program = function()
            return vim.fn.input({
                prompt = "Path to dll",
                default = vim.fn.getcwd() .. "/bin/Debug/",
            })
        end,
    },
}

-- Highlight the line that is currently being executed.
vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

local icons = require("custom.util.icons").dap
for name, sign in pairs(icons) do
    sign = type(sign) == "table" and sign or { sign }
    vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
    )
end
