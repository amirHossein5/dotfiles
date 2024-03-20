require('amirhossein5.remap')
require('amirhossein5.lazy_init')
require('amirhossein5.set')
require('amirhossein5.blade')

vim.api.nvim_create_autocmd({"BufWritePre"}, {
    pattern = "*",
    command = [[%s/\s\+$//e]]
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
