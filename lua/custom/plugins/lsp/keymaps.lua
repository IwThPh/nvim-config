local M = {}

---@type PluginLspKeys
M._keys = nil

---@return (LazyKeys|{has?:string})[]
function M.get()
  local format = function()
    vim.lsp.buf.format()
  end
  if not M._keys then
    ---@class PluginLspKeys
    -- stylua: ignore
    M._keys = {
      { "<leader>cl", "<cmd>LspInfo<cr>",                                                                     desc = "Lsp Info" },
      { "gd",         function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end,      desc = "Goto Definition",       has = "definition" },
      { "gr",         "<cmd>Telescope lsp_references<cr>",                                                    desc = "References" },
      { "gD",         vim.lsp.buf.declaration,                                                                desc = "Goto Declaration" },
      { "gI",         function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end,  desc = "Goto Implementation" },
      { "gy",         function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, desc = "Goto T[y]pe Definition" },
      { "K",          vim.lsp.buf.hover,                                                                      desc = "Hover" },
      { "gK",         vim.lsp.buf.signature_help,                                                             desc = "Signature Help",        has = "signatureHelp" },
      { "<c-k>",      vim.lsp.buf.signature_help,                                                             mode = "i",                     desc = "Signature Help", has = "signatureHelp" },
      { "<leader>cf", format,                                                                                 desc = "Format Document",       has = "formatting" },
      { "<leader>cf", format,                                                                                 desc = "Format Range",          mode = "v",              has = "rangeFormatting" },
      { "<leader>ca", vim.lsp.buf.code_action,                                                                desc = "Code Action",           mode = { "n", "v" },     has = "codeAction" },
      {
        "<leader>cA",
        function()
          vim.lsp.buf.code_action({
            context = { only = { "source" }, diagnostics = {} },
          })
        end,
        desc = "Source Action",
        has = "codeAction",
      },
      { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
    }
  end
  return M._keys
end

---@type LazyKeysLspSpec[]|nil
M._keys = nil

---@alias LazyKeysLspSpec LazyKeysSpec|{has?:string}
---@alias LazyKeysLsp LazyKeys|{has?:string}

---@param method string
function M.has(buffer, method)
  method = method:find("/") and method or "textDocument/" .. method
  local clients = require("custom.util").lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

---@return (LazyKeys|{has?:string})[]
function M.resolve(buffer)
  local Keys = require("lazy.core.handler.keys")
  if not Keys.resolve then
    return {}
  end
  local spec = M.get()
  local opts = require("custom.util").opts("nvim-lspconfig")
  local clients = require("custom.util").lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
    vim.list_extend(spec, maps)
  end
  return Keys.resolve(spec)
end

function M.on_attach(_, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = M.resolve(buffer)

  for _, keys in pairs(keymaps) do
    if not keys.has or M.has(buffer, keys.has) then
      local opts = Keys.opts(keys)
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
    end
  end
end

return M
