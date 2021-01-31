-- require'nvim-web-devicons'.setup()

local gl = require('galaxyline')
local gls = gl.section
gl.short_line_list = {'LuaTree','vista','dbui'}

local colors = {
  bg = '#1d212f',
  yellow = '#ffcb6b',
  cyan = '#89DDFF',
  darkblue = '#939ede',
  green = '#C3e88d',
  orange = '#f78c6c',
  purple = '#c792ea',
  magenta = '#d16d9e',
  grey = '#bfc7d5',
  blue = '#82b1ff',
  red = '#ff5370'
}

-- Palenight Colors
-- "red"#ff5370"
-- "light_red"#ff869a"
-- "dark_red"#BE5046"
-- "green"#C3E88D"
-- "yellow"#ffcb6b"
-- "dark_yellow"#F78C6C"
-- "blue"#82b1ff"
-- "purple"#c792ea"
-- "blue_purple"#939ede"
-- "cyan"#89DDFF"
-- "white"#bfc7d5"
-- "black"#292D3E"
-- "comment_grey"#697098"
-- "gutter_fg_grey"#4B5263"
-- "cursor_grey"#2C323C"
-- "visual_grey"#3E4452"
-- "menu_grey"#3E4452"
-- "special_grey"#3B4048"
-- "vertsplit"#181A1F"
-- "white_mask_1"#333747"
-- "white_mask_3"#474b59"
-- "white_mask_11"#989aa2"

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

local checkwidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

gls.left[1] = {
  FirstElement = {
    provider = function() return '▋ ' end,
    highlight = {colors.cyan,colors.bg}
  },
}
gls.left[2] = {
  ViMode = {
    provider = function()
      local alias = {n = ' NORMAL ',i = ' INSERT ',c= ' COMMAND ',t = ' TERMINAL ',v= ' VISUAL ',V= ' V-LINE ', [''] = ' VISUAL '}
      return alias[vim.fn.mode()]
    end,
    separator = '▋ ',
    separator_highlight = {colors.cyan,colors.bg},
    highlight = {colors.yellow,colors.bg,'bold'},
  },
}
gls.left[3] ={
  FileIcon = {
    separator = '',
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = {colors.magenta,colors.bg},
  },
}
gls.left[4] = {
  FileName = {
    provider = {'FileName'},
    condition = buffer_not_empty,
    separator = ' ',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.magenta,colors.bg}
  }
}
gls.left[5] = {
  LeftEnd = {
    provider = function() return ' ' end,
    separator = ' ',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.purple,colors.bg}
  }
}
gls.left[6] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
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
    icon = '  ',
    highlight = {colors.yellow,colors.bg},
  }
}
gls.left[9] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = '   ',
    highlight = {colors.blue,colors.bg},
  }
}
gls.left[10] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '   ',
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
    separator_highlight = {colors.purple,colors.bg},
    condition = buffer_not_empty,
    highlight = {colors.grey,colors.bg},
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
  LineInfo = {
    provider = 'LineColumn',
    separator = ' | ',
    separator_highlight = {colors.darkblue,colors.bg},
    highlight = {colors.grey,colors.bg},
  },
}
gls.right[7] = {
  PerCent = {
    provider = 'LinePercent',
    separator = ' |',
    separator_highlight = {colors.darkblue,colors.bg},
    highlight = {colors.grey,colors.bg},
  }
}
gls.right[8] = {
  ScrollBar = {
    provider = 'ScrollBar',
    highlight = {colors.yellow,colors.bg},
  }
}

gls.short_line_left[1] = {
  LeftEnd = {
    provider = function() return ' ' end,
    separator = ' ',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.purple,colors.bg}
  }
}
