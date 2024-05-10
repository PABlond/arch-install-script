local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath
        }
    )
end
vim.opt.rtp:prepend(lazypath)

vim.opt.number = true
vim.opt.relativenumber = true

vim.keymap.set({'i'}, '<C-s>', '<C-o>:w<ENTER>')
vim.keymap.set({'n'}, '<C-s>', ':w<ENTER>')

vim.keymap.set("i", "jj", "<ESC>", { silent = true })

require("lazy").setup(
    {
        {
            -- package recommended by https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion/217feffc675a17d8ab95259ed9d4c6d62e1cd2e1#autocompletion-not-built-in-vs-completion-built-in
            "hrsh7th/nvim-cmp",
            config = function(cmp)
                local cmp = require("cmp")
                cmp.setup(
                    {
                        completion = {completeopt = "menu,menuone,noinsert"},
                        -- if desired, choose another keymap-preset:
                        mapping = cmp.mapping.preset.insert(),
                        -- optionally, add more completion-sources:
                        sources = cmp.config.sources({{name = "nvim_lsp"}})
                    }
                )
            end
        },
        ---- code formatting

        {
            "mhartington/formatter.nvim",
            config = function()
                local formatter_prettier = {require("formatter.defaults.prettier")}
                require("formatter").setup(
                    {
                        filetype = {
                            javascript = formatter_prettier,
                            javascriptreact = formatter_prettier,
                            typescript = formatter_prettier,
                            typescriptreact = formatter_prettier
                        }
                    }
                )
                -- automatically format buffer before writing to disk:
                vim.api.nvim_create_augroup("BufWritePreFormatter", {})
                vim.api.nvim_create_autocmd(
                    "BufWritePre",
                    {
                        command = "FormatWrite",
                        group = "BufWritePreFormatter",
                        pattern = {"*.js", "*.jsx", "*.ts", "*.tsx"}
                    }
                )
            end,
            ft = {"javascript", "javascriptreact", "typescript", "typescriptreact"}
        },
        ---- language server protocol (lsp)

        {
            -- use official lspconfig package (and enable completion):
            "neovim/nvim-lspconfig",
            dependencies = {"hrsh7th/cmp-nvim-lsp"},
            config = function()
                local lsp_capabilities =
                    require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
                local lsp_on_attach = function(client, bufnr)
                    local bufopts = {noremap = true, silent = true, buffer = bufnr}
                    -- following keymap is based on both lspconfig and lsp-zero.nvim:
                    -- - https://github.com/neovim/nvim-lspconfig/blob/fd8f18fe819f1049d00de74817523f4823ba259a/README.md?plain=1#L79-L93
                    -- - https://github.com/VonHeikemen/lsp-zero.nvim/blob/18a5887631187f3f7c408ce545fd12b8aeceba06/lua/lsp-zero/server.lua#L285-L298
                    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
                    vim.keymap.set("n", "go", vim.lsp.buf.type_definition, bufopts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
                    --m.keymap.set('n', TODO   , vim.lsp.buf.code_action                           , bufopts) -- lspconfig: <space>ca; lsp-zero: <F4>
                    --m.keymap.set('n', TODO   , function() vim.lsp.buf.format { async = true } end, bufopts) -- lspconfig: <space>f
                    --m.keymap.set('n', TODO   , vim.lsp.buf.rename                                , bufopts) -- lspconfig: <space>rn; lsp-zero: <F2>
                end
                local lspconfig = require("lspconfig")
                -- enable both language-servers for both eslint and typescript:
                for _, server in pairs({"eslint", "tsserver"}) do
                    lspconfig[server].setup(
                        {
                            capabilities = lsp_capabilities,
                            on_attach = lsp_on_attach
                        }
                    )
                end
            end,
            ft = {"javascript", "javascriptreact", "typescript", "typescriptreact"}
        },
        {
            "hrsh7th/nvim-cmp",
            config = function()
                local cmp = require("cmp")
                vim.opt.completeopt = "menu,menuone,noselect"

                cmp.setup(
                    {
                        mapping = cmp.mapping.preset.insert(
                            {
                                ["C-j"] = cmp.mapping.select_next_item()
                                -- other mappings...
                            }
                        ),
                        sources = cmp.config.sources(
                            {
                                -- order is matter
                                {name = "nvim_lsp"}
                                -- { name = 'path' },
                                -- { name = 'buffer' },
                            }
                        )
                    }
                )
            end
        },
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            config = true
            -- use opts = {} for passing setup options
            -- this is equalent to setup({}) function
        },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                require("nvim-treesitter.configs").setup(
                    {
                        -- for syntax-highlight, instead of regular expressions, use tree-sitter:
                        highlight = {
                            enable = true,
                            additional_vim_regex_highlighting = false
                        }
                    }
                )
            end
        },
        {
            "windwp/nvim-ts-autotag",
            config = function()
                require("nvim-ts-autotag").setup()
                require("nvim-treesitter.configs").setup(
                    {
                        ensure_installed = {
                            "tsx",
                            "c",
                            "c_sharp",
                            "css",
                            "go",
                            "graphql",
                            "html",
                            "json",
                            "http",
                            "javascript",
                            "lua",
                            "markdown",
                            "python",
                            "rust",
                            "typescript",
                            "yaml",
                            "bash",
                            "comment",
                            "java"
                        },
                        sync_install = false,
                        highlight = {enable = true, additional_vim_regex_highlighting = true},
                        indent = {enable = true, disable = {"yaml"}},
                        rainbow = {enable = true, extended_mode = true, max_file_lines = nil},
                        context_commentstring = {enable = true, enable_autocmd = false},
                        autotag = {enable = true}
                    }
                )
            end
        },
        ---- indendation detection
        -- automatically configure indentation when a file is opened.

        {"nmac427/guess-indent.nvim"},
        {
            "williamboman/mason.nvim",
            config = function()
                require("mason").setup()
            end
        },
        {
            "stevearc/oil.nvim",
            opts = {},
            -- Optional dependencies
            dependencies = {"nvim-tree/nvim-web-devicons"},
            config = function()
                require("oil").setup()
                vim.keymap.set("n", "-", "<CMD>Oil<CR>", {desc = "Open parent directory"})
            end
        },
        {
            "nvim-telescope/telescope.nvim",
            tag = "0.1.6",
            dependencies = {"nvim-lua/plenary.nvim"}
        },
        {
            "scottmckendry/cyberdream.nvim",
            lazy = false,
            priority = 1000,
            config = function()
                require("cyberdream").setup(
                    {
                        transparent = true,
                        italic_comments = true,
                        hide_fillchars = true,
                        borderless_telescope = true,
                        terminal_colors = true
                    }
                )
                vim.cmd("colorscheme cyberdream") -- set the colorscheme
            end
        }
    }
)
