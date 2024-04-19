local plugins = {

	-- Folke's good stuff
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{ "folke/trouble.nvim" },
	{
		"folke/todo-comments.nvim",
		opts = {},
	},
    { "nvim-lua/plenary.nvim" },
	{ "williamboman/mason.nvim" },
	{ "nvimdev/lspsaga.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "onsails/lspkind.nvim" },
	{ "nvimtools/none-ls.nvim" },
	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/nvim-cmp" },
	{ "L3MON4D3/LuaSnip" },
	{ "mrjones2014/smart-splits.nvim", lazy = true },
	{ "kylechui/nvim-surround" },
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		defaults = {
			lazy = false,
			version = nil,
		},
		build = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
				},
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"David-Kunz/treesitter-unit",
			"windwp/nvim-ts-autotag",
		},
	},
	{
		"numToStr/Comment.nvim",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"sindrets/diffview.nvim", -- optional - Diff integration
		},
		config = true,
	},
	{ "norcalli/nvim-colorizer.lua" },
	{ "windwp/nvim-autopairs" },
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
        ---- indendation detection
        -- automatically configure indentation when a file is opened.

        {"nmac427/guess-indent.nvim"},
        {
            'dense-analysis/ale',
            config = function()
                -- Configuration goes here.
                local g = vim.g

                g.ale_ruby_rubocop_auto_correct_all = 1

                g.ale_linters = {
                    typescript = {'prettier', 'eslint'},
                    typescriptreact = {'prettier', 'eslint'},
                    css = {'prettier'},
                    json = {'prettier'},
                    javascript = {'prettier', 'eslint'},
                    ruby = {'rubocop', 'ruby'},
                    lua = {'lua_language_server'}
                }
            end
        },
        {
            "akinsho/bufferline.nvim",
            version = "*",
            dependencies = "nvim-tree/nvim-web-devicons",
            config = function()
                require("bufferline").setup()
            end
        },
        {
            'stevearc/oil.nvim',
            opts = {},
            dependencies = { "nvim-tree/nvim-web-devicons" },
            config = function()
                require("oil").setup({
                    default_file_explorer = true,
                    view_options = {
                        show_hidden = true
                    }
                })
            end
        }
}

require("lazy").setup(plugins, opts)
