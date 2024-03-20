vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = '*.blade.php',
    callback = function()
        vim.opt.ft = 'html'
    end
})
