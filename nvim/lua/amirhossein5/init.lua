require('amirhossein5.remap')
require('amirhossein5.lazy_init')
require('amirhossein5.set')
require('amirhossein5.blade')
require('amirhossein5.auto_dark_mode')

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = vim.api.nvim_create_augroup("Personal", {}),
    pattern = "*",
    command = [[:exec 'norm m`' | %s/\s\+$//e | norm g``]]
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
