local ls = require('luasnip')

vim.keymap.set({ "i", "s", "n" }, "<C-l>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s", "n" }, "<C-k>", function() ls.jump(-1) end, { silent = true })

require('luasnip/loaders/from_snipmate').lazy_load()
