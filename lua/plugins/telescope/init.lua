-- Highlight groups.
local nvim_cmd = vim.api.nvim_command
nvim_cmd([[ hi def link TelescopeSelection LspDiagnosticsVirtualTextWarning ]])
nvim_cmd([[ hi def link TelescopeSelectionCaret Keyword ]])
nvim_cmd([[ hi def link TelescopeMultiSelection Normal ]])
nvim_cmd([[ hi def link TelescopeNormal TelescopeNormal ]])
nvim_cmd([[ hi def link TelescopeBorder CursorLineNr ]])
nvim_cmd([[ hi def link TelescopeResultsBorder Normal ]])
nvim_cmd([[ hi def link TelescopePreviewBorder Normal ]])
nvim_cmd([[ hi def link TelescopeMatching LspDiagnosticsWarning ]])
nvim_cmd([[ hi def link TelescopePromptPrefix Keyword ]])
