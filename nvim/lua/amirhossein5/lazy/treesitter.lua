return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',

    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = { "javascript", "jsdoc", "typescript", "c", "lua", "vim", "vimdoc", "rust", "php", "phpdoc", "bash" },

            indent = {
                enable = true,
            },

            highlight = {
                -- `false` will disable the whole extension
                enable = true,

                disable = function(lang, buf)
                    if lang == 'html' then
                        return true
                    end

                    local max_filesize = 200 * 1024 -- 200 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
            },
        }
    end
};
