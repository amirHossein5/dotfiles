return {
    "stevearc/conform.nvim",
    event = { "BufReadPost", "BufNewFile", "InsertEnter" },
    config = function()
        local conform = require('conform')

        conform.setup({
            formatters_by_ft = {
                javascript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescript = { "prettierd" },
                typescriptreact = { "prettierd" },
                vue = { "prettierd" },
                css = { "prettierd" },
                json = { "prettierd" },
                yaml = { "prettierd" },
                markdown = { "prettierd" },
                graphql = { "prettierd" },
                html = { "blade-formatter" },
                go = { 'goimports' },
            },
            formatters = {
                ['blade-formatter'] = {
                    args = { "--stdin", "--wrap-attributes=aligned-multiple" },
                },
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>f", function()
            conform.format({
                lsp_fallback = true,
            })

            vim.cmd("write")
        end)
    end
}
