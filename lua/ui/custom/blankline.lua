local palette = require("ui.theme").get_palette()

return {
   IndentBlankLineChar = {
	  fg = palette.comment,
	  nocombine = true,
   },
   IndentBlankLineSpaceChar = {
	  fg = palette.comment,
	  nocombine = true,
   },
   IndentBlankLineSpaceCharBlankLine = {
	  fg = palette.comment,
	  nocombine = true,
   },

   IndentBlankLineContextChar = {
	  nocombine = true,
   },
   IndentBlankLineContextStart = {
	  underline = true,
	  nocombine = true,
   },
}
