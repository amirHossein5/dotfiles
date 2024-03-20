require('amirhossein5.packer')
vim.cmd('source ~/.config/nvim/lua/amirhossein5/set.vim')
require('amirhossein5.remap')

vim.cmd('source ~/.config/nvim/lua/amirhossein5/blade.vim')
vim.api.nvim_create_autocmd({"BufWritePre"}, {
    group = vim.api.nvim_create_augroup("Personal", {}),
    pattern = "*",
    command = [[:exec 'norm m`' | %s/\s\+$//e | norm g``]]
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
