if not pcall(require, 'telescope') then
  return
end

TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(key, f, options, buffer)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  local mode = "n"
  local rhs = string.format(
    "<cmd>lua R('plugin.telescope')['%s'](TelescopeMapArgs['%s'])<CR>",
    f,
    map_key
  )

  local map_options = { noremap = true, silent = true, }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end

-- Dotfiles
map_tele('<leader>en', 	'edit_neovim')

-- General 
map_tele('<C-f>', 		'project_search')
map_tele('<leader>g', 	'live_grep')
map_tele('<leader>b', 	'buffers')
map_tele('<leader>fh', 	'help_tags')
map_tele('<C-g>', 		'git_status')
map_tele('<leader>co', 	'git_branches')

return map_tele

