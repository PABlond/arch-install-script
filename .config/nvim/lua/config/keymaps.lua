-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("n", "<leader>s", "<cmd>bprev<CR>")
vim.keymap.set("n", "<leader>d", "<cmd>bnext<CR>")
vim.keymap.set("n", "<leader>q", "<cmd>bdelete<CR>")
