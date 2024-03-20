return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.6',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{
			"nvim-telescope/telescope-live-grep-args.nvim",
			version = "^1.0.0",
		},
	},

	config = function()
		local lga_actions = require("telescope-live-grep-args.actions")

		require('telescope').setup({
			defaults = {
				mappings = {
					i = {
						['<C-u>'] = false,
					}
				}
			},
			extensions = {
				live_grep_args = {
					mappings = {
						i = {
							["<C-k>"] = lga_actions.quote_prompt(),
						},
					},
				}
			}
		})

		vim.keymap.set(
			'n',
			'<leader>pg',
			":lua require('telescope').extensions.live_grep_args.live_grep_args({ vimgrep_arguments = { 'rg', '--hidden', '--ignore', '-g=!.git/**', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' } }) <CR>"
		)

		local builtin = require('telescope.builtin')

		local t = ':Telescope find_files find_command=rg,--hidden,--files'
		vim.keymap.set('n', '<c-p>', t .. ',--ignore,-g=!.git<CR>')
		vim.keymap.set('n', '<leader>pf', t .. ',--no-ignore<CR>')
		vim.keymap.set('n', '<leader>b', builtin.buffers)
		vim.keymap.set('n', '<leader>vh', builtin.help_tags)
	end
}
