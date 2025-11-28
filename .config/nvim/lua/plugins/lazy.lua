-- Configuration de lazy.nvim
-- Fichier: ~/.config/nvim/lua/plugins/lazy.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Charger tous les plugins depuis le dossier plugins
local plugins = {}
local plugin_files = vim.fn.glob("~/.config/nvim/lua/plugins/*.lua", false, true)

for _, file in ipairs(plugin_files) do
  -- Ignorer lazy.lua lui-même
  if not file:match("lazy%.lua$") then
    local plugin = require("plugins." .. vim.fn.fnamemodify(file, ":t:r"))
    table.insert(plugins, plugin)
  end
end

require("lazy").setup(plugins)
