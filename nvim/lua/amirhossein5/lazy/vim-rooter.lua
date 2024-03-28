return {
    'airblade/vim-rooter',

    config = function()
        vim.g.rooter_manual_only = 1
        vim.g.rooter_patterns = { '.git', 'composer.json', 'composer.lock', 'package.json', 'package-lock.json', '.gitignore' }
        vim.cmd('Rooter')
    end
}
