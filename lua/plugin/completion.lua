local cmp = require'cmp'
local lspkind = require'lspkind'

cmp.setup {
	snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
	completion = {
		completeopt='menu,menuone,noinsert,noselect'
	},

	formatting = {
		format = function(_, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			return vim_item
		end
	},

	documentation = {
		border =  {"🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏"},
	},

	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = function(fallback)
			if vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
			else
				fallback()
			end
		end,
		['<S-Tab>'] = function(fallback)
			if vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
			else
				fallback()
			end
		end,
	},

	sources = {
		{ name='nvim_lsp' },
		{ name='nvim_lua' },
		{ name='buffer' },
		{ name='path' },
	},
}

-- Mappings.
require'snippets'.use_suggested_mappings()
