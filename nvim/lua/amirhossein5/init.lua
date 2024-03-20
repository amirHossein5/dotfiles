require('amirhossein5.packer')
vim.cmd('source ~/.config/nvim/lua/amirhossein5/set.vim')
require('amirhossein5.remap')

vim.cmd('source ~/.config/nvim/lua/amirhossein5/blade.vim')
vim.api.nvim_create_autocmd({"BufWritePre"}, {
    pattern = "*",
    command = [[%s/\s\+$//e]]
})
