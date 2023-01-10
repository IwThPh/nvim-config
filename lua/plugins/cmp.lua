local M = {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',
		'petertriho/cmp-git',
        'rafamadriz/friendly-snippets',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
    },
}

local has_words_before = function()
    local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local function setupLuaSnip()
    local luasnip = require('luasnip')
    luasnip.config.set_config({
        history = true,
        updateevents = 'TextChanged,TextChangedI',
    })
    require('luasnip.loaders.from_vscode').lazy_load()

    vim.api.nvim_create_autocmd('InsertLeave', {
        callback = function()
            if luasnip.session.current_nodes[vim.api.nvim_get_current_buf()] and not luasnip.session.jump_active then
                luasnip.unlink_current()
            end
        end,
    })
end

local function setupCmp()
    local luasnip = require('luasnip')
    local cmp = require('cmp')

    vim.opt.completeopt = 'menuone,noselect'

    local function border(hl_name)
        return {
            { '╭', hl_name },
            { '─', hl_name },
            { '╮', hl_name },
            { '│', hl_name },
            { '╯', hl_name },
            { '─', hl_name },
            { '╰', hl_name },
            { '│', hl_name },
        }
    end

    local cmp_window = require('cmp.utils.window')

    cmp_window.info_ = cmp_window.info
    cmp_window.info = function(self)
        local info = self:info_()
        info.scrollable = false
        return info
    end

    local options = {
        experimental = {
            ghost_text = true,
        },
        window = {
            completion = {
                border = border('CmpBorder'),
                winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None',
            },
            documentation = {
                border = border('CmpDocBorder'),
            },
        },
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        formatting = {
            format = function(_, vim_item)
                local icons = require('ui.icons').lspkind
                vim_item.kind = string.format('%s %s', icons[vim_item.kind], vim_item.kind)
                return vim_item
            end,
        },
        mapping = {
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            }),
            ['<Tab>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(1) then
                    luasnip.jump(1)
                elseif cmp.visible() then
                    cmp.select_next_item()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, {
                'i',
                's',
            }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                elseif cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, {
                'i',
                's',
            }),
        },
        sources = {
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'git' },
            { name = 'nvim_lua' },
            { name = 'luasnip' },
            { name = 'path' },
            { name = 'buffer' },
        },
    }

    cmp.setup(options)
end

function M.config()
    setupLuaSnip()
    setupCmp()

	-- Git commit completion
	require("cmp_git").setup({
		remotes = { "upstream", "origin", "origin-gh" }
	})
end

return M
