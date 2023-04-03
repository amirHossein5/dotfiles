local opts = {noremap = true, silent = true};

vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', opts);
vim.api.nvim_set_keymap('n', ';', '<cmd>FineCmdline<CR>', opts);
