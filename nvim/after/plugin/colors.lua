require('rose-pine').setup({
	disable_background = true,
})

function SetTheme(theme)
	vim.cmd.colorscheme(theme)

	if theme == 'tokyonight-night' then
		vim.cmd("hi StatusLine guibg=#1f1d2e")
		vim.cmd("hi ColorColumn guibg=#1f1d2e")
	end
end

SetTheme('rose-pine')
