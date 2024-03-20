local lsp_zero = require('lsp-zero')
local lua_opts = lsp_zero.nvim_lua_ls()

lsp_zero.set_sign_icons({
    error = '',
    warn = '',
    hint = '',
    info = ''
})

lsp_zero.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "H", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set({ "n", "i" }, "<C-s>", function() vim.lsp.buf.signature_help() end, opts)
end)

local lspconfig = require('lspconfig')

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'tsserver', 'rust_analyzer', 'emmet_ls', 'intelephense' },
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            lspconfig.lua_ls.setup(lua_opts)
        end,
        clangd = function()
            lspconfig.clangd.setup({
                cmd = {
                    "clangd",
                    "--fallback-style=webkit"
                }
            })
        end,
        pylsp = function()
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
        end
    }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'buffer',  keyword_length = 3 },
    },
    formatting = lsp_zero.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ['<C-y>'] = cmp.mapping(function()
            if not cmp.visible() then
                cmp.complete()
            end
            cmp.confirm({ select = true })
        end),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<c-j>'] = cmp.mapping.scroll_docs(4),
        ['<c-k>'] = cmp.mapping.scroll_docs(-4),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
})

require('lspconfig').emmet_ls.setup({
    filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue", "blade" },
})

vim.opt.pumheight = 4

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