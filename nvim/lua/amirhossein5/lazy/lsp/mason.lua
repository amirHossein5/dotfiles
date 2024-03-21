return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig",
    },
    config = function()
        require("mason").setup()

        require('mason-lspconfig').setup({
            ensure_installed = {
                'lua_ls',
                'cssls',
				'rust_analyzer',
				'tsserver',
				'vimls',
				'emmet_ls',
				'intelephense',
				'tailwindcss',
				'gopls',
				'clangd',
				'pylsp',
            },

            automatic_installation = true,
        })
    end
}
