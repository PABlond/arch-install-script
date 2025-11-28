-- Options de base de Neovim
-- Fichier: ~/.config/nvim/lua/config/options.lua

vim.opt.number = true -- Numéros de ligne
vim.opt.relativenumber = true -- Numéros de ligne relatifs
vim.opt.tabstop = 2 -- 2 espaces pour les tabulations
vim.opt.shiftwidth = 2 -- 2 espaces pour l'indentation
vim.opt.expandtab = true -- Convertit les tabulations en espaces
vim.opt.smartindent = true -- Indentation intelligente
vim.opt.wrap = false -- Pas de retour à la ligne automatique
vim.opt.termguicolors = true -- Support des couleurs 24-bit
vim.opt.cursorline = true -- Surligner la ligne du curseur
vim.opt.signcolumn = "yes" -- Toujours afficher la colonne des signes
vim.opt.clipboard = "unnamedplus" -- Synchronisation avec le presse-papiers système
vim.opt.mouse = "a" -- Activer la souris
vim.opt.updatetime = 300 -- Mise à jour rapide pour une meilleure réactivité
vim.opt.hidden = true -- Permettre de changer de buffer sans sauvegarder

-- Curseur plus visible (bloc en mode normal)
vim.opt.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"
