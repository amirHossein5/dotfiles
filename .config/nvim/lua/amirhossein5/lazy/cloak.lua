return {
    "laytan/cloak.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("cloak").setup({
            enabled = true,
            cloak_character = "*",
            highlight_group = "Comment",
            patterns = {
                {
                    file_pattern = {
                        ".env*",
                    },
                    cloak_pattern = "=.+"
                },
                {
                    file_pattern = {
                        ".env.example",
                    },
                    cloak_pattern = {}
                },
            },
        })
    end
}
