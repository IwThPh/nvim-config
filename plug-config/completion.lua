vim.api.nvim_set_option('completeopt', 'menu,menuone,noinsert,noselect')

require'compe'.setup {
  enabled = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  -- throttle_time = ... number ...;
  -- source_timeout = ... number ...;
  -- incomplete_delay = ... number ...;
  allow_prefix_unmatch = false;

  source = {
    path = true;
    buffer = true;
    vsnip = true;
    nvim_lsp = true;
    -- nvim_lua = { ... overwrite source configuration ... };
  };
}
