-- Fichier principal de configuration Neovim
-- Fichier: ~/.config/nvim/init.lua

-- Définir la touche <leader> comme la barre d'espace
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Charger les configurations générales
require("config.options")
require("config.keymaps")
require("config.diagnostics")

-- Initialiser lazy.nvim
require("plugins.lazy")
