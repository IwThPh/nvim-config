return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    local logo = [[
            .    _  _  _  /_ .//._   _  _/_              
           /|/|//_|/ //_// //////_/_\./_//_'|/           
                     /         /                         
                                                         
          Iwan Phillips <iwan@iwanphillips.dev>          
        ]]
    opts.section.header.val = vim.split(logo, "\n", { trimempty = true })
  end,
}
