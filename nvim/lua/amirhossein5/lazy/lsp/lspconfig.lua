function SetupLSPs(lspconfig)
    lspconfig.intelephense.setup {}
    lspconfig.cssls.setup {}
    lspconfig.gopls.setup {}
    lspconfig.vimls.setup {}
    lspconfig.rust_analyzer.setup {}
    lspconfig.tsserver.setup {}
    lspconfig.tailwindcss.setup {}
    lspconfig.clangd.setup({
        cmd = {
            "clangd",
            "--fallback-style=webkit"
        }
    })
    lspconfig.pylsp.setup({
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
    lspconfig.lua_ls.setup {
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
    lspconfig.emmet_ls.setup({
        filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue", "blade" },
    })
end

function SetupRemaps()
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
            local opts = { buffer = ev.buf }

            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'H', vim.lsp.buf.hover, opts)
            vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<leader>f', function()
                vim.lsp.buf.format { async = true }
            end, opts)
        end,
    })
end

vim.diagnostic.config({
    virtual_text = true,
    underline = true,
    signs = true,
})

vim.api.nvim_create_user_command("ToggleDiagnostic", function()
    local config = vim.diagnostic.config
    local vt = config().virtual_text
    config {
        virtual_text = not vt,
        underline = not vt,
        signs = not vt,
    }
end, { desc = "toggle diagnostic" })

return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require('lspconfig')

        SetupLSPs(lspconfig)
        SetupRemaps()
    end
}
