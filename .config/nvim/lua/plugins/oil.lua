-- Configuration de oil.nvim
-- Fichier: ~/.config/nvim/lua/plugins/oil.lua

return {
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("oil").setup({
      -- Configuration par défaut
      default_file_explorer = true,
      -- Afficher les fichiers cachés
      view_options = {
        show_hidden = true,
      },
      -- Configuration des raccourcis clavier
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
      -- Configuration de l'interface
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
      -- Configuration des icônes
      use_default_keymaps = false,
      -- Configuration des fenêtres
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "n",
      },
    })

    -- Raccourcis clavier pour ouvrir/fermer oil
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set("n", "=", "<CMD>Oil<CR>", { desc = "Open current directory" })
  end,
} 