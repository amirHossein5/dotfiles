function SetTheme(theme, background)
    background = background or 'dark';

    vim.cmd.colorscheme(theme)

    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    -- vim.cmd("highlight ColorColumn guibg=#0d0c0c")

    if background == "light" then
        vim.cmd("let $BAT_THEME='gruvbox-light'");
    else
        vim.cmd("let $BAT_THEME='gruvbox-dark'");
    end

    vim.opt.background = background;
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
        priority = 1,
        config = function()
            require('rose-pine').setup({
                variant = 'moon',
                styles = {
                    italic = false,
                },
                highlight_groups = {
                    ["DiffAdd"] = { fg = '#67a95b', bg = 'NONE' },
                    ["DiffDelete"] = { fg = '#FA5057', bg = 'NONE' },
                }
            })
        end
    },
    {
        "morhetz/gruvbox",
        priority = 1,
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

            vim.cmd("hi DiffAdded guifg=#67a95b guibg=NONE")
            vim.cmd("hi DiffRemoved guifg=#FA5057 guibg=NONE")
        end
    },
}
