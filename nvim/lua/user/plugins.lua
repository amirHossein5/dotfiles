vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use ({'wbthomason/packer.nvim'})
	use({
        'voldikss/vim-floaterm',
        config = function ()
            require('user.plugins.floaterm');
        end
    })
    use {
        'VonHeikemen/fine-cmdline.nvim',
        requires = {
            {'MunifTanjim/nui.nvim'}
        },
        config = function ()
            require('user.plugins.cmdline');
        end
    }
end);
