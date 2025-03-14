return {
    'folke/trouble.nvim',
    keys = { "<leader>tr" },
    cmd = "Trouble",

    config = function()
        require('trouble').setup({
            fold_open = "v",      -- icon used for open folds
            fold_closed = ">",    -- icon used for closed folds
            indent_lines = false, -- add an indent guide below the fold icons
            signs = {
                -- icons / text used for a diagnostic
                error = "error",
                warning = "warn",
                hint = "hint",
                information = "info"
            },
            use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
        })

        vim.keymap.set("n", "<leader>tr", function()
            require("trouble").toggle({
                mode = 'diagnostics'
            })
        end)

        vim.keymap.set("n", "[t", function()
            require("trouble").next({ skip_groups = true, jump = true })
        end)

        vim.keymap.set("n", "]t", function()
            require("trouble").previous({ skip_groups = true, jump = true })
        end)
    end
}
