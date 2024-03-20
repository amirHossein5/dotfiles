return {
    'phpactor/phpactor',
    ft = 'php',
    config = function()
        vim.keymap.set('n', '<Leader>pm', ':PhpactorContextMenu<CR>')
        vim.keymap.set('n', '<Leader>pn', ':PhpactorClassNew<CR>')
        vim.keymap.set('n', '<Leader>e', ':PhpactorClassExpand<CR>')
        vim.keymap.set('n', '<Leader>i', ':PhpactorImportClass<CR>')
        vim.keymap.set('n', '<Leader>pt', ':PhpactorTransform<CR>')
    end,
}
