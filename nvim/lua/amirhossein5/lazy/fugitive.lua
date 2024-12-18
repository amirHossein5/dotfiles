return {
    'tpope/vim-fugitive',
    dependencies = 'tpope/vim-rhubarb',
    version = '*',
    keys = { "<leader>gi" },
    cmd = { "Git", "Gwrite" },

    config = function()
        vim.keymap.set("n", "<leader>gi", vim.cmd.Git)

        local autocmd = vim.api.nvim_create_autocmd
        autocmd("BufWinEnter", {
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local bufnr = vim.api.nvim_get_current_buf()
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "<leader>gp", function()
                    vim.cmd.Git('push')
                end, opts)

                vim.keymap.set("n", "<leader>gfp", function()
                    vim.cmd.Git('push --force-with-lease')
                end, opts)

                -- rebase always
                vim.keymap.set("n", "<leader>gP", function()
                    vim.cmd.Git('pull --rebase')
                end, opts)
            end,
        })
    end
}
