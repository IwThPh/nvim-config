-- require'nvim-web-devicons'.setup()

local gl = require('galaxyline')
local gls = gl.section
gl.short_line_list = {'LuaTree','vista','dbui','startify','chadtree', 'NvimTree'}

local getHighlightTerm = function(group, term)
	local hi = vim.api.nvim_exec([[execute('hi ' . "]] .. group .. [[")]], true)
	return string.match(hi, [[ .* ]] .. term .. [[=(#[%w]+).*]])
end

local colors = require('galaxyline.theme').default
colors.bg = getHighlightTerm('StatusLine', 'guibg');

local buffer_not_empty = function()
  return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
end

local checkwidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  return squeeze_width > 40
end

gls.left[1] = {
  FirstElement = {
    provider = function() return ' ' end,
    highlight = {colors.cyan,colors.bg}
  },
}
gls.left[2] = {
  ViMode = {
    provider = function()
      local alias = {n = 'NORMAL',i = 'INSERT',c= 'COMMAND',t = 'TERMINAL',v= 'VISUAL',V= 'V-LINE', [''] = 'VISUAL'}
      return alias[vim.fn.mode()]
    end,
    separator = ' ',
    separator_highlight = {colors.cyan,colors.bg},
    highlight = {colors.yellow,colors.cyan,'bold'},
  },
}
gls.left[3] = {
  FileName = {
    provider = function()
		return vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.');
	end,
    condition = buffer_not_empty,
    separator = ' ',
    separator_highlight = {colors.violet,colors.bg},
    highlight = {colors.magenta,colors.bg}
  },
}
gls.left[4] ={
  FileIcon = {
    separator = '',
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = {colors.magenta,colors.bg},
  },
}
gls.left[5] = {
  LeftEnd = {
    provider = function() return ' ' end,
    separator = ' ',
    separator_highlight = {colors.violet,colors.bg},
    highlight = {colors.violet,colors.bg}
  }
}
gls.left[6] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red,colors.bg}
  }
}
gls.left[7] = {
  Space = {
    provider = function () return '' end
  }
}
gls.left[8] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.yellow,colors.bg},
  }
}
gls.left[9] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = '  ',
    highlight = {colors.blue,colors.bg},
  }
}
gls.left[10] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = {colors.orange,colors.bg},
  }
}

gls.right[1] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = checkwidth,
    -- separator = ' ',
    -- separator_highlight = {colors.purple,colors.bg},
    icon = '  ',
    highlight = {colors.green,colors.bg},
  }
}
gls.right[2] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = checkwidth,
    -- separator = ' ',
    -- separator_highlight = {colors.purple,colors.bg},
    icon = '  ',
    highlight = {colors.blue,colors.bg},
  }
}
gls.right[3] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = checkwidth,
    -- separator = ' ',
    -- separator_highlight = {colors.purple,colors.bg},
    icon = '  ',
    highlight = {colors.red,colors.bg},
  }
}
gls.right[4] = {
  GitBranch = {
    provider = 'GitBranch',
    separator = ' ',
    separator_highlight = {colors.violet,colors.bg},
    condition = buffer_not_empty,
    highlight = {colors.fg,colors.bg},
  }
}
gls.right[5] = {
  GitIcon = {
    provider = function() return ' ' end,
    condition = buffer_not_empty,
    highlight = {colors.orange,colors.bg},
  }
}

gls.right[6] = {
  ShowLspClient = {
    provider = 'GetLspClient',
    separator = ' | ',
    separator_highlight = {colors.darkblue,colors.bg},
    highlight = {colors.fg,colors.bg},
  },
}

gls.right[7] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' | ',
    separator_highlight = {colors.darkblue,colors.bg},
    highlight = {colors.fg,colors.bg},
  },
}
gls.right[8] = {
  PerCent = {
    provider = 'LinePercent',
    separator = ' |',
    separator_highlight = {colors.darkblue,colors.bg},
    highlight = {colors.fg,colors.bg},
  }
}
gls.right[9] = {
  ScrollBar = {
    provider = 'ScrollBar',
    highlight = {colors.yellow,colors.bg},
  }
}

gls.short_line_left[1] = {
  LeftEnd = {
    provider = function() return ' ' end,
    separator = ' ',
    separator_highlight = {colors.violet,colors.bg},
    highlight = {colors.violet,colors.bg}
  }
}
