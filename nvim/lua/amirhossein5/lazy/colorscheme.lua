function SetTheme(theme)
    vim.cmd.colorscheme(theme)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    {
        'folke/tokyonight.nvim',
        lazy = true,

        config = function()
            require("tokyonight").setup({
                transparent = true,
                styles = {
                    comments = { italic = false },
                    keywords = { italic = false },
                },
            })

            vim.cmd("hi diffAdded guifg=#67a95b guibg=NONE")
            vim.cmd("hi diffRemoved guifg=#FA5057 guibg=NONE")
        end
    },
    {
        'rose-pine/neovim',

        config = function()
            require('rose-pine').setup({
                disable_background = true,
                styles = {
                    bold = false,
                }
            })

            SetTheme('rose-pine')

            vim.cmd("hi diffAdd guifg=#67a95b guibg=NONE")
            vim.cmd("hi diffDelete guifg=#FA5057 guibg=NONE")
        end
    },
    {
        'catppuccin/nvim',
        as = "catppuccin",
        config = function()
            vim.cmd("hi diffAdded guifg=#67a95b guibg=NONE")
            vim.cmd("hi diffRemoved guifg=#FA5057 guibg=NONE")
            vim.cmd("hi ColorColumn guibg=#181825")
        end
    },
}
