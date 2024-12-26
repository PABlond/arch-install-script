local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

require("lazy").setup("plugins")

-- Oil 
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-- Buffer management
vim.keymap.set("n", "<leader>=", ':lua require("buffer_manager.ui").toggle_quick_menu()<CR>')
vim.keymap.set("n", "<leader>q", ":bw!<CR>")

vim.api.nvim_set_keymap(
  "i", 
  "<CR>", 
  [[coc#pum#visible() ? coc#pum#confirm() : "\<CR>"]], 
  { noremap = true, expr = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>e",
  ":CocList diagnostics<CR>",
  { noremap = true, silent = true }
)

--vim.api.nvim_create_autocmd("BufWritePre", {
--  pattern = "*",
--  callback = function()
--    vim.fn["CocAction"]("format")
--  end,
--})
--vim.api.nvim_create_autocmd("BufWritePre", {
--  pattern = "*",
--  callback = function()
--    vim.lsp.buf.format({ async = false })
--  end,
--})
--
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.ts,*.tsx",
  callback = function()
    vim.cmd("silent !prettier --write %")
    vim.cmd("edit") -- Recharge le fichier pour appliquer les changements
  end,
})
