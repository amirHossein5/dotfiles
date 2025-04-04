vim.opt.guicursor = ""
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.scrolloff = 8
vim.opt.signcolumn = "no"
vim.opt.laststatus = 1
vim.opt.colorcolumn = "80"
vim.g.mapleader = ' '

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.api.nvim_create_autocmd("BufWinEnter", { pattern = '*.blade.php', callback = function() vim.opt.ft = 'html' end })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({ {
    'vim-test/vim-test',
    keys = { "<leader>tn", "<leader>tf", "<leader>ts", "<leader>tl", "<leader>tw" },

    config = function()
        vim.cmd([[
            nnoremap <Leader>tn :w<CR> :tabonly<CR> :silent TestNearest<CR>
            nnoremap <Leader>tf :w<CR> :tabonly<CR> :TestFile<CR>
            nnoremap <Leader>ts :w<CR> :tabonly<CR> :TestSuite<CR>
            nnoremap <Leader>tl :w<CR> :tabonly<CR> :TestLast<CR>
            nnoremap <Leader>tw :w<CR> :TestVisit<CR>

            let g:test#basic#start_normal = 1
            let test#php#phpunit#executable = 'phpunit'
        ]])
    end
}, {
    'mbbill/undotree',
    keys = { "<leader>u" },

    config = function()
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
}, {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',

    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = { "javascript", "jsdoc", "typescript", "c", "lua", "vim", "vimdoc", "rust", "php", "phpdoc", "bash" },

            auto_install = true,

            indent = {
                enable = true,
                disable = { 'html' },
            },

            highlight = {
                enable = false,

                disable = function(lang, buf)
                    local disableLangs = { html = true }

                    if disableLangs[lang] then
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
}, {
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
    keys = { "<leader>pg" },

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
}, {
    "phpactor/phpactor",
    ft = "php",
    version = "*",
    build = "composer install --no-dev -o",
    config = function()
        vim.keymap.set("n", "<Leader>pm", ":PhpactorContextMenu<CR>")
        vim.keymap.set("n", "<Leader>pn", ":PhpactorClassNew<CR>")
        vim.keymap.set("n", "<Leader>e", ":PhpactorClassExpand<CR>")
        vim.keymap.set("n", "<Leader>i", ":PhpactorImportClass<CR>")
        vim.keymap.set("n", "<Leader>pt", ":PhpactorTransform<CR>")
    end,
}, {
    'tpope/vim-eunuch',
}, {
    'tpope/vim-sleuth',
}, {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        "<leader>a", "<leader>w",
        "<c-h>", "<c-t>", "<c-n>", "<c-m>", "<c-,>", "<c-.>",
    },

    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
        vim.keymap.set("n", "<leader>w", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<C-m>", function() harpoon:list():select(4) end)
        vim.keymap.set("n", "<C-,>", function() harpoon:list():select(5) end)
        vim.keymap.set("n", "<C-.>", function() harpoon:list():select(6) end)
    end
}, {
    dependencies = { 'junegunn/fzf', run = "fzf#install()" },
    keys = { "<c-p>" },
    "junegunn/fzf.vim",
    config = function()
        vim.cmd([[
            let g:fzf_vim = {}

            let g:fzf_vim.preview_window = ['hidden', 'ctrl-/']
            let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.87, 'yoffset': 0.3 } }
            let $FZF_DEFAULT_OPTS = '--bind ctrl-k:preview-up,ctrl-j:preview-down --bind alt-a:select-all,alt-d:deselect-all'
            let $FZF_PREVIEW_COMMAND = "cat {}"

            function! s:build_quickfix_list(lines)
                call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
                copen
                cc
            endfunction

            let g:fzf_action = {
            \ 'alt-q': function('s:build_quickfix_list'), }

            command! -bang -nargs=* PFiles
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({
            \   'source': 'rg --hidden --files --ignore -g="!.git"',
            \ }), <bang>0)

        ]])

        vim.keymap.set('n', '<leader>pf', ':Files<CR>')
        vim.keymap.set('n', '<leader>b', ':Buffers<CR>')
        vim.keymap.set('n', '<c-p>', ':PFiles<CR>')
    end
}, {
    'tpope/vim-fugitive',
    dependencies = 'tpope/vim-rhubarb',
    version = '*',
    keys = { "<leader>gi" },
    cmd = { "Git", "Gwrite" },

    config = function()
        vim.keymap.set("n", "<leader>gi", vim.cmd.Git)

        local autocmd = vim.api.nvim_create_autocmd
        autocmd("BufWinEnter", {
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local bufnr = vim.api.nvim_get_current_buf()
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "<leader>gp", function()
                    vim.cmd.Git('push')
                end, opts)

                vim.keymap.set("n", "<leader>gfp", function()
                    vim.cmd.Git('push --force-with-lease')
                end, opts)

                -- rebase always
                vim.keymap.set("n", "<leader>gP", function()
                    vim.cmd.Git('pull --rebase')
                end, opts)
            end,
        })
    end
}, {
    "brenoprata10/nvim-highlight-colors",
    config = function()
        vim.opt.termguicolors = true
        require('nvim-highlight-colors').setup({})
        require("nvim-highlight-colors").turnOff()
    end
}, {
    "laytan/cloak.nvim",
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
}, {
    "stevearc/conform.nvim",
    config = function()
        local conform = require('conform')

        conform.setup({
            formatters_by_ft = {
                javascript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescript = { "prettierd" },
                typescriptreact = { "prettierd" },
                vue = { "prettierd" },
                css = { "prettierd" },
                json = { "prettierd" },
                yaml = { "prettierd" },
                markdown = { "prettierd" },
                graphql = { "prettierd" },
                html = { "blade-formatter" },
                go = { 'goimports' },
            },
            formatters = {
                ['blade-formatter'] = {
                    args = { "--stdin", "--wrap-attributes=aligned-multiple" },
                },
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>f", function()
            conform.format({
                lsp_fallback = true,
            })

            vim.cmd("write")
        end)
    end
}, {
    "neovim/nvim-lspconfig",
    config = function()
        vim.keymap.set('n', '[d', vim.diagnostic.goto_next)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_prev)

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                local opts = { buffer = ev.buf }

                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'H', vim.lsp.buf.hover, opts)
                vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
            end,
        })
    end
}, {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig",
        "neovim/nvim-lspconfig",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        require("mason").setup()
        require('mason-lspconfig').setup({
            ensure_installed = {
                'cssls',
                'emmet_language_server',
                'intelephense',
                'tailwindcss',
                'clangd',
            },
            automatic_installation = true,
            handlers = {
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities
                    })
                end,

                ["clangd"] = function()
                    lspconfig.clangd.setup({
                        on_attach = function(client)
                            client.server_capabilities.semanticTokensProvider = nil
                        end,
                        capabilities = capabilities,
                        cmd = {
                            "clangd",
                            "--fallback-style=webkit"
                        }
                    })
                end,

                ["pylsp"] = function()
                    lspconfig.pylsp.setup({
                        capabilities = capabilities,
                        settings = {
                            pylsp = {
                                plugins = {
                                    rope_autoimport = {
                                        enabled = true
                                    }
                                }
                            }
                        }
                    })
                end,

                ["ts_ls"] = function()
                    lspconfig.ts_ls.setup {
                        on_attach = function(client)
                            client.server_capabilities.semanticTokensProvider = nil
                        end,
                    }
                end,

                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" },
                                },
                                workspace = {
                                    library = {
                                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                        [vim.fn.stdpath("config") .. "/lua"] = true,
                                    }
                                }
                            }
                        }
                    }
                end,
            },
        })

        require("mason-tool-installer").setup({
            ensure_installed = {
                -- "prettierd", "oxlint", "blade-formatter", "goimports"
            }
        })
    end
}, {
    "hrsh7th/nvim-cmp",
    dependencies = {
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',

        'dcampos/nvim-snippy',
        'dcampos/cmp-snippy',
    },
    config = function()
        local cmp = require('cmp')

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('snippy').expand_snippet(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-y>'] = cmp.mapping(function()
                    if not cmp.visible() then cmp.complete() end
                    cmp.confirm({ select = true })
                end),
                ['<c-j>'] = cmp.mapping.scroll_docs(4),
                ['<c-k>'] = cmp.mapping.scroll_docs(-4),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'snippy' },
                { name = 'path' },
            }, {
                { name = 'buffer' },
            })
        })

        require('snippy').setup({
            mappings = {
                is = {
                    ['<c-l>'] = 'next',
                    ['<c-h>'] = 'previous',
                },
            }
        })

        vim.opt.pumheight = 5
    end
},
    { "morhetz/gruvbox", },
}, {
    change_detection = { notify = false },
    ui = { icons = { cmd = "⌘", config = "🛠", event = "📅", ft = "📂", init = "⚙", keys = "🗝", plugin = "🔌", runtime = "💻", require = "🌙", source = "📄", start = "🚀", task = "📌", lazy = "💤 ", }, },
})

function St(theme, background, no_bg)
    background = background or 'dark';
    no_bg = no_bg or false;

    vim.cmd.colorscheme(theme)

    if theme == 'gruvbox' then
        vim.cmd([[highlight Normal guibg=#1c1c1c]])
    end

    if no_bg then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end

    vim.cmd("highlight ColorColumn guibg=#141414")

    vim.opt.background = background;
end

St('gruvbox', 'dark')
