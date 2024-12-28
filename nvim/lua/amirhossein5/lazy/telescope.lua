return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            "nvim-telescope/telescope-live-grep-args.nvim",
            version = "^1.0.0",
        },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build =
            'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
        }
    },

    config = function()
        local previewers = require('telescope.previewers')

        local new_maker = function(filepath, bufnr, opts)
            opts = opts or {}

            filepath = vim.fn.expand(filepath)
            vim.loop.fs_stat(filepath, function(_, stat)
                if not stat then return end
                if stat.size > 100 * 1024 then
                    return
                else
                    previewers.buffer_previewer_maker(filepath, bufnr, opts)
                end
            end)
        end

        local lga_actions = require("telescope-live-grep-args.actions")

        require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        ['<C-u>'] = false,
                    }
                },
                buffer_previewer_maker = new_maker,
            },
            extensions = {
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                },
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
    end
}
