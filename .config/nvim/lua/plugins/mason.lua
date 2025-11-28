-- Configuration de mason.nvim
-- Fichier: ~/.config/nvim/lua/plugins/mason.lua

return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  cmd = "Mason",
  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
  end,
} 