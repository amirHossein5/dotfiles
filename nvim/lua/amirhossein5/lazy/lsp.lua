return {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    config = function()
        require('mason').setup()
        require('mason-lspconfig').setup()
    end
}

-- return {
--     'VonHeikemen/lsp-zero.nvim',
--     branch = 'v3.x',
--     dependencies = {
--         -- LSP Support
--         { 'neovim/nvim-lspconfig' },
--         { 'williamboman/mason.nvim' },
--         { 'williamboman/mason-lspconfig.nvim' },
--
--         -- Autocompletion
--         { 'hrsh7th/nvim-cmp' },
--         { 'hrsh7th/cmp-buffer' },
--         { 'hrsh7th/cmp-path' },
--         { 'saadparwaiz1/cmp_luasnip' },
--         { 'hrsh7th/cmp-nvim-lsp' },
--         { 'hrsh7th/cmp-nvim-lua' },
--
--         -- Snippets
--         { 'L3MON4D3/LuaSnip' },
--     }
-- }
