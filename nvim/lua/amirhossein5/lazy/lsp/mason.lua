function SetupLSPs(lspconfig, capabilities)
    return {
        function(server_name)
            lspconfig[server_name].setup({
                capabilities = capabilities
            })
        end,

        ["clangd"] = function()
            lspconfig.clangd.setup({
                capabilities = capabilities,
                cmd = {
                    "clangd",
                    "--fallback-style=webkit"
                }
            })
        end,

        ["pylsp"] = function()
            lspconfig.pylsp.setup({
                capabilities = capabilities,
                settings = {
                    pylsp = {
                        plugins = {
                            rope_autoimport = {
                                enabled = true
                            }
                        }
                    }
                }
            })
        end,

        ["lua_ls"] = function()
            lspconfig.lua_ls.setup {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                            }
                        }
                    }
                }
            }
        end,

        ["emmet_ls"] = function()
            lspconfig.emmet_ls.setup({
                capabilities = capabilities,
                filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue", "blade" },
            })
        end,
    }
end

return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig",
        "neovim/nvim-lspconfig",
    },
    config = function()
        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
            handlers = SetupLSPs(lspconfig, capabilities),
        })
    end
}