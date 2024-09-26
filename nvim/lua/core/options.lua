local opts = {
	shiftwidth = 4,
	tabstop = 4,
	expandtab = true,
	wrap = false,
	termguicolors = true,
	number = true,
	relativenumber = true,
}

-- Set options from table
for opt, val in pairs(opts) do
	vim.o[opt] = val
end

-- Set other options

vim.g.termguicolors=true
vim.api.nvim_set_option("termguicolors", true)
vim.opt.termguicolors = true

local colorscheme = require("helpers.colorscheme")
vim.cmd.colorscheme(colorscheme)

