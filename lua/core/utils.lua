-- Taken from TJDevries
P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, 'plenary') then
  RELOAD = require('plenary.reload').reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end


U = {}

-- Keymaps
U.keymap = {}

function U.keymap.map(mode, key, cmd, opts)
	local options = { noremap = true, silent = true }
	if (opts) then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, key, cmd, options)
end

function U.keymap.buf_map(mode, key, cmd, opts)
	local options = { noremap = true, silent = true }
	if (opts) then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_buf_set_keymap(mode, key, cmd, options)
end


-- Vim source
function U.source(file, base)
	if base == nil then base = '~/.config/nvim' end
	vim.cmd('source ' .. base .. file)
end
