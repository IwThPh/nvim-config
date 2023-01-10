return {
    'nvim-lua/plenary.nvim',
    'tpope/vim-surround',
    'lewis6991/impatient.nvim',
    'famiu/bufdelete.nvim',
    'MunifTanjim/nui.nvim',

    {
        'antoinemadec/FixCursorHold.nvim',
        config = function()
            vim.g.cursorhold_updatetime = 100
        end,
    },

    {
        'kyazdani42/nvim-web-devicons',
        config = function()
            require('nvim-web-devicons').setup({ override = require('ui.icons').devicons })
        end,
    },

    {
        'luukvbaal/stabilize.nvim',
        config = function()
            require('stabilize').setup()
        end,
    },

    {
        'kevinhwang91/nvim-ufo',
        dependencies = { 'kevinhwang91/promise-async' },
        config = function()
            local o = vim.o
            o.foldcolumn = '1'
            o.foldnestmax = '1'
            o.foldlevel = 99
            o.foldlevelstart = 99
            o.foldenable = true
            o.fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:⏵]]
            o.statuscolumn = '%=%l%s%C'

            local set = vim.keymap.set
            set('n', 'zR', require('ufo').openAllFolds)
            set('n', 'zM', require('ufo').closeAllFolds)
			require('ufo').setup({
				open_fold_hl_timeout = 0
			})
        end,
    },

    'numToStr/Comment.nvim',

    {
        'rcarriga/nvim-notify',
        config = function()
            local notify = require('notify')
            vim.notify = function(msg, log_level)
                if msg:match('exit code') then
                    return
                end
                if log_level == vim.log.levels.ERROR then
                    vim.api.nvim_err_writeln(msg)
                else
                    notify(msg, log_level)
                end
            end

            notify.setup({ stages = 'slide' })
        end,
    },

    {
        'j-hui/fidget.nvim',
        dependencies = { 'nvim-lspconfig' },
        config = function()
            require('fidget').setup({})
        end,
    },

    {
        'hood/popui.nvim',
        dependencies = { 'RishabhRD/popfix' },
        config = function()
            vim.ui.select = require('popui.ui-overrider')
            vim.ui.input = require('popui.input-overrider')
        end,
    },

    'vim-test/vim-test',

    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'antoinemadec/FixCursorHold.nvim',
        },
    },

    {
        'karb94/neoscroll.nvim',
        config = function()
            require('neoscroll').setup()
            require('neoscroll.config').set_mappings({
                ['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '50' } },
                ['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '50' } },
            })
        end,
    },

    {
        'nvim-neotest/neotest-vim-test',
        dependencies = { 'vim-test', 'neotest' },
        config = function()
            require('neotest').setup({
                adapters = {
                    -- Or to only allow specified file types
                    require('neotest-vim-test')({ allow_file_types = { 'php' } }),
                },
            })
        end,
    },
}
