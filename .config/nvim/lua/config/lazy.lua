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
vim.cmd.colorscheme "cyberdream"
-- Oil 
vim.keymap.set("n", "=", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-- Buffer management
vim.keymap.set("n", "<leader>=", ':lua require("buffer_manager.ui").toggle_quick_menu()<CR>')
vim.keymap.set("n", "<leader>q", ":bw!<CR>")
-- Fzf
vim.keymap.set("n", "<leader>sf", ":FzfLua grep<CR>")

vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus"  -- Active le presse-papiers système

-- Raccourcis pour copier/coller/couper/sélectionner
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true, desc = "Copy to system clipboard" })
vim.keymap.set("n", "<C-v>", '"+p', { noremap = true, silent = true, desc = "Paste from system clipboard" })
vim.keymap.set("i", "<C-v>", '<C-r>+', { noremap = true, silent = true, desc = "Paste from system clipboard" })
vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, silent = true, desc = "Select all text" })
vim.keymap.set("v", "<C-x>", '"+x', { noremap = true, silent = true, desc = "Cut to system clipboard" })

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


-- Fonction pour obtenir le chemin relatif et le copier
local function copy_relative_path()
  -- Récupère le chemin absolu du fichier courant
  local absolute_path = vim.fn.expand('%:p')
  -- Récupère le répertoire de travail (par exemple ~/.dev/monprojet)
  local project_root = vim.fn.getcwd()
  -- Calcule le chemin relatif
  local relative_path = vim.fn.substitute(absolute_path, project_root .. '/', '', '')
  -- Copie dans le presse-papiers (utilise le registre '+' pour le presse-papiers système)
  vim.fn.setreg('+', relative_path)
  -- Message de confirmation
  print('Chemin relatif copié : ' .. relative_path)
end

-- Associe la fonction à une commande utilisateur
vim.api.nvim_create_user_command('CopyRelPath', copy_relative_path, {})

-- Mappe la combinaison '@.' à cette commande
vim.keymap.set('n', '@.', ':CopyRelPath<CR>', { noremap = true, silent = true })
