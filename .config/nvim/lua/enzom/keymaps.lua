vim.g.mapleader = ";"
local keymap = vim.keymap

keymap.set("n", "x", '"_x')

keymap.set("n", "<leader>q", ":q<CR>")

keymap.set("i", "jk", "<Esc>")
keymap.set("n", "<C-d>", ":BufDel<CR>")
keymap.set("n", "<C-s>", ":w<CR>")

keymap.set("n", "<C-j>", "<C-d>")
keymap.set("n", "<C-k>", "<C-u>")

keymap.set("n", "<C-n>", ":Neotree toggle<CR>")

keymap.set("n", "<Space>d", ":%bd|e#<CR>")

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- New tab
keymap.set("n", "te", ":tabedit")
-- Split window
keymap.set("n", "ss", ":split<Return><C-w>w")
keymap.set("n", "sv", ":vsplit<Return><C-w>w")
-- Move window
keymap.set("n", "<Space>", "<C-w>w")
keymap.set("", "sh", "<C-w>h")
keymap.set("", "sk", "<C-w>k")
keymap.set("", "sj", "<C-w>j")
keymap.set("", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

keymap.set("n", "<leader>gi", ":Neogit<CR>")

-- Treesitter-units
keymap.set("x", "iu", ':lua require"treesitter-unit".select()<CR>')
keymap.set("x", "au", ':lua require"treesitter-unit".select(true)<CR>')
keymap.set("o", "iu", ':<c-u>lua require"treesitter-unit".select()<CR>')
keymap.set("o", "au", ':<c-u>lua require"treesitter-unit".select(true)<CR>')

-- Harpoon
keymap.set("n", "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>")
keymap.set("n", "<leader>ht", ":lua require('harpoon.ui').toggle_quick_menu()<CR>")
keymap.set("n", "<A-1>", ":lua require('harpoon.ui').nav_file(1)<CR>")
keymap.set("n", "<A-2>", ":lua require('harpoon.ui').nav_file(2)<CR>")
keymap.set("n", "<A-3>", ":lua require('harpoon.ui').nav_file(3)<CR>")
keymap.set("n", "<A-4>", ":lua require('harpoon.ui').nav_file(4)<CR>")

-- Neorg
keymap.set("n", "<leader>n", ":Neorg workspace notes<CR>")

-- Zen Mode
keymap.set("n", "<space>z", ":ZenMode<CR>")
