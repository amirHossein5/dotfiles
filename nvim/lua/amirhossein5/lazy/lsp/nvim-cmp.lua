return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',

        'dcampos/nvim-snippy',
        'dcampos/cmp-snippy',
    },
    config = function()
        local cmp = require('cmp')

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('snippy').expand_snippet(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-y>'] = cmp.mapping(function()
                    if not cmp.visible() then cmp.complete() end
                    cmp.confirm({ select = true })
                end),
                ['<c-j>'] = cmp.mapping.scroll_docs(4),
                ['<c-k>'] = cmp.mapping.scroll_docs(-4),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'snippy' },
                { name = 'path' },
            }, {
                { name = 'buffer' },
            })
        })

        require('snippy').setup({
            mappings = {
                is = {
                    ['<c-l>'] = 'next',
                    ['<c-h>'] = 'previous',
                },
            }
        })

        vim.opt.pumheight = 4
    end
}
