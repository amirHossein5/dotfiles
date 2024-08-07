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
                style = "night",
            })

            vim.cmd("hi diffAdded guifg=#67a95b guibg=NONE")
            vim.cmd("hi diffRemoved guifg=#FA5057 guibg=NONE")
        end
    },
    {
        'rose-pine/neovim',

        config = function()
            require('rose-pine').setup({
                variant = 'moon',
                disable_background = true,
                styles = {
                    italic = false,
                },
            })

            vim.cmd("hi diffAdd guifg=#67a95b guibg=NONE")
            vim.cmd("hi diffDelete guifg=#FA5057 guibg=NONE")
        end
    },
    {
        "morhetz/gruvbox",
        priority=1, -- loads colors better
        config = function()
            vim.cmd.colorscheme("gruvbox")
        end
    },
    {
        'LunarVim/darkplus.nvim',
        config = function()
            -- SetTheme('darkplus')

            vim.cmd("hi signColumn guibg=transparent")
            vim.cmd("hi MsgArea guibg=transparent")
            vim.cmd("hi ModeMsg guibg=transparent")
            vim.cmd("hi Visual guibg=#0f354f")
            vim.cmd("hi MatchParen guibg=#1f2e3f")

            vim.cmd("hi TelescopeSelection guibg=#0f354f")
            vim.cmd("hi TelescopeSelectionCaret guibg=#0f354f guifg=gray")

            vim.cmd("hi diffAdded guifg=#67a95b guibg=NONE")
            vim.cmd("hi diffRemoved guifg=#FA5057 guibg=NONE")
        end
    },
}
