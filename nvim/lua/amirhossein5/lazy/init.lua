return {
    {
        'numToStr/Comment.nvim',
        event = { "BufReadPre", "BufNewFile", "InsertEnter" },
        config = true
    },

    {
        'tpope/vim-eunuch',
        event = { "BufReadPre", "BufNewFile", "InsertEnter" },
    },
}
