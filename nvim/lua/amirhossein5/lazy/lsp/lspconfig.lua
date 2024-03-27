function SetDiagnostics(enabled)
    vim.diagnostic.config({
        virtual_text = enabled,
        underline = enabled,
        signs = enabled,
    })
end

SetDiagnostics(false)

vim.api.nvim_create_user_command("ToggleDiagnostics", function()
    SetDiagnostics(not vim.diagnostic.config().virtual_text)
end, {})

return {
    "neovim/nvim-lspconfig",
    config = function()
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
            end,
        })
    end
}
