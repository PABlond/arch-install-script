local lsp_zero = require("lsp-zero")
local lspkind = require("lspkind")
local saga = require("lspsaga")

saga.setup({
	ui = {
		border = "rounded",
	},
	symbol_in_winbar = {
		enable = false,
	},
	lightbulb = {
		enable = false,
	},
	outline = {
		layout = "float",
	},
})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<S-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "md", "<Cmd>Lspsaga show_line_diagnostics<CR>", opts)
vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "gd", "<Cmd>Lspsaga goto_definition<CR>", opts)
vim.keymap.set("n", "gt", "<Cmd>Lspsaga goto_type_definition<CR>", opts)
-- vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
-- vim.keymap.set("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
vim.keymap.set("n", "gp", "<Cmd>Lspsaga peek_definition<CR>", opts)
vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)

-- code action
vim.keymap.set("n", ";af", "<cmd>Lspsaga code_action<CR>")

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"tsserver",
		"marksman",
		"lua_ls",
		"prismals",
		"tailwindcss",
		"astro",
		"cssls",
		"cssmodules_ls",
		"html",
	},
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require("lspconfig").lua_ls.setup(lua_opts)
		end,
	},
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

local function formatForTailwindCSS(entry, vim_item)
	if vim_item.kind == "Color" and entry.completion_item.documentation then
		local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
		if r then
			local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
			local group = "Tw_" .. color
			if vim.fn.hlID(group) < 1 then
				vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
			end
			vim_item.kind = "●"
			vim_item.kind_hl_group = group
			return vim_item
		end
	end
	vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
	return vim_item
end

cmp.setup({
	sources = {
		-- { name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
	},
	formatting = {
		lsp_zero.cmp_format(),
		format = lspkind.cmp_format({
			maxwidth = 50,
			before = function(entry, vim_item)
				vim_item = formatForTailwindCSS(entry, vim_item)
				return vim_item
			end,
		}),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
		["<Enter>"] = cmp.mapping.confirm({ select = true }),
		["<C-l>"] = cmp.mapping.complete(),
		["<C-space>"] = cmp.mapping.complete(),
	}),
})
