return {
  "nvimdev/dashboard-nvim",
  opts = function(_, opts)
    local logo = [[
            .    _  _  _  /_ .//._   _  _/_              
           /|/|//_|/ //_// //////_/_\./_//_'|/           
                     /         /                         
                                                         
          Iwan Phillips <iwan@iwanphillips.dev>          
        ]]
    opts.config.header = vim.split(logo, "\n", { trimempty = true })
  end,
}
