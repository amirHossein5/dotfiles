local opts = {noremap = true, silent = true};

vim.g.mapleader = ' ';
vim.g.maplocalleader = ' ';

vim.keymap.set('n', '<leader>ps', ':packersync<cr>', opts, opts);
vim.keymap.set('n', '<leader>k', ':nohlsearch<CR>', opts);
vim.keymap.set('n', '<leader>q', ':q<CR>', opts);
vim.keymap.set('n', '<leader>Q', ':bufdo bdelete<CR>', opts);
vim.keymap.set('n', '<leader>b', ':Lexplore 20<CR><CR>', opts);
vim.keymap.set('n', '<leader>w', vim.cmd.w, opts);
vim.keymap.set('n', ';', ':', opts);

-- auto completion
vim.keymap.set('i', '<C- >', '<C-n>', opts);

-- allow gf to open non-existent files
vim.keymap.set('', 'gf', ':edit <cfile><cr>', opts)

-- Reselect visual selection after indenting
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y', opts)
vim.keymap.set('v', 'Y', 'myY`y', opts)

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true }, opts)
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true }, opts)

-- Paste replace visual selection without copying it
vim.keymap.set('v', 'p', '"_dP', opts)

-- exit insert mode
vim.keymap.set('i', 'jk', '<esc>', opts);
vim.keymap.set('i', 'kj', '<esc>', opts);
vim.keymap.set('i', ';;', '<Esc>A;<Esc>', opts)

-- Open the current file in the default program (on Mac this should just be just `open`)
vim.keymap.set('n', '<leader>x', ':!xdg-open %<cr><cr>', opts)

-- Move text up and down
vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi', opts)
vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi', opts)
vim.keymap.set('n', '<A-j>', '<Esc>:move .+1<CR>==g<Esc>', opts)
vim.keymap.set('n', '<A-k>', '<Esc>:move .-2<CR>==g<Esc>', opts)
vim.keymap.set('x', '<A-j>', ":move '>+1<CR>gv-gv", opts)
vim.keymap.set('x', '<A-k>', ":move '<-2<CR>gv-gv", opts)

-- Movements in insert mode
vim.keymap.set('i', '<C-j>', '<down>', opts)
vim.keymap.set('i', '<C-k>', '<up>', opts)
vim.keymap.set('i', '<C-h>', '<left>', opts)
vim.keymap.set('i', '<C-l>', '<right>', opts)

-- Resize
vim.keymap.set('n', '<C-k>', ':resize +2<CR>')
vim.keymap.set('n', '<C-j>', ':resize -2<CR>')
vim.keymap.set('n', '<C-h>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-l>', ':vertical resize +2<CR>')



