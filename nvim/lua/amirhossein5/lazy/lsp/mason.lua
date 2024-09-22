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

        ["ts_ls"] = function()
            lspconfig.ts_ls.setup {
                on_attach = function(client)
                    client.server_capabilities.semanticTokensProvider = nil
                end,
            }
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
    }
end

return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig",
        "neovim/nvim-lspconfig",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
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
                'ts_ls',
                'vimls',
                'emmet_language_server',
                'intelephense',
                'tailwindcss',
                'gopls',
                'pylsp',
                'clangd',
            },
            automatic_installation = true,
            handlers = SetupLSPs(lspconfig, capabilities),
        })

        require("mason-tool-installer").setup({
            ensure_installed = {
                "prettierd", "oxlint", "blade-formatter", "goimports"
            }
        })
    end
}
