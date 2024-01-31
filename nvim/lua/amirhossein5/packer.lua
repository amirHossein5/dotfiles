vim.cmd('source ~/.config/nvim/lua/amirhossein5/plugins/greplace.vim')

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use { 'wbthomason/packer.nvim' }

    use "nvim-lua/plenary.nvim"
    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    use { "catppuccin/nvim", as = "catppuccin" }
    use { 'folke/tokyonight.nvim' }
    use { 'nordtheme/vim' }

    use { 'junegunn/fzf', run = ":call fzf#install()" }
    use { 'junegunn/fzf.vim' }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
        }
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                sticky = false,
            })
        end
    }

    use { 'tpope/vim-surround' }
    use { 'tpope/vim-eunuch' }
    use { 'tpope/vim-fugitive', dependencies = 'tpope/vim-rhubarb' }
    use { 'tpope/vim-sleuth' }
    use { 'tpope/vim-vinegar' }

    use { 'jessarcher/vim-heritage' }

    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup { map_cr = true, map_complete = true } end
    }

    use { 'airblade/vim-rooter' }

    use { 'vim-test/vim-test' }

    use {
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

    use { 'mbbill/undotree' }

    use {
        'NvChad/nvim-colorizer.lua',
        config = function()
            require 'colorizer'.setup({
                user_default_options = {
                    names = false,
                }
            })
        end
    }

    use { 'folke/trouble.nvim' }
    use { 'folke/zen-mode.nvim' }
end)
