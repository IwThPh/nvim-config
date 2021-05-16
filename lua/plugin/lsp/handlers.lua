--Custom LSP Handlers
vim.lsp.handlers["textDocument/definition"] = function(_, _, result)
  if not result or vim.tbl_isempty(result) then
    print("[LSP] Could not find definition")
    return
  end

  if vim.tbl_islist(result) then
    vim.lsp.util.jump_to_location(result[1])
  else
    vim.lsp.util.jump_to_location(result)
  end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  require('lsp_extensions.workspace.diagnostic').handler, {
    signs = {
      severity_limit = "Warning",
    }
  }
)

vim.fn.sign_define("LspDiagnosticsSignError", { text="" })
vim.fn.sign_define("LspDiagnosticsSignWarning", { text="" })
vim.fn.sign_define("LspDiagnosticsSignInformation", { text="" })
vim.fn.sign_define("LspDiagnosticsSignHint", { text="" })

vim.lsp.handlers["textDocument/hover"] = require('lspsaga.hover').handler

