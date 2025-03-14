require('amirhossein5.remap')
require('amirhossein5.lazy_init')
require('amirhossein5.set')

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = vim.api.nvim_create_augroup("Personal", {}),
    pattern = "*",
    command = [[:exec 'norm m`' | %s/\s\+$//e | norm g``]]
})

vim.api.nvim_create_autocmd("BufWinEnter", { pattern = '*.blade.php', callback = function() vim.opt.ft = 'html' end })

-- local job = require('plenary.job'):new({
--   command = 'gsettings',
--   args = { 'get', 'org.gnome.desktop.interface', 'color-scheme' },
-- })
--
-- if job:sync()[1] == "'prefer-dark'" then
--   SetTheme('gruvbox', 'dark')
-- elseif job:sync()[1] == "'prefer-light'" then
--   SetTheme('gruvbox', 'light')
-- end
