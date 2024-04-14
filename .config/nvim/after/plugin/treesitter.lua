local status, ts = pcall(require, "nvim-treesitter.configs")
require("treesitter-context").setup()
if not status then
	return
end

ts.setup({
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = true,
		disable = {},
	},
	ensure_installed = {
		"markdown",
		"markdown_inline",
		"tsx",
		"typescript",
		"javascript",
		"toml",
		"json",
		"yaml",
		"css",
		"html",
		"lua",
		"astro",
	},
	autotag = {
		enable = true,
		enable_rename = true,
		enable_close = true,
		enable_close_on_slash = false,
	},
})

require("ts_context_commentstring").setup()
vim.g.skip_ts_context_commentstring_module = true

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
