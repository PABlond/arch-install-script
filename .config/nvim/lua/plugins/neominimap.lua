-- Configuration de Satellite.nvim
-- Scrollbar avec minimap visuelle (barres de couleur)
-- Fichier: ~/.config/nvim/lua/plugins/neominimap.lua

return {
  "lewis6991/satellite.nvim",
  event = "VeryLazy",
  config = function()
    require("satellite").setup({
      current_only = false,
      winblend = 50,
      zindex = 40,
      excluded_filetypes = {
        "NvimTree",
        "alpha",
        "lazy",
        "mason",
        "TelescopePrompt",
        "neo-tree",
      },
      width = 2,
      handlers = {
        cursor = {
          enable = true,
          symbols = { '⎺', '⎻', '⎼', '⎽' }
        },
        search = {
          enable = true,
        },
        diagnostic = {
          enable = true,
          signs = {'-', '=', '≡'},
          min_severity = vim.diagnostic.severity.HINT,
        },
        gitsigns = {
          enable = true,
          signs = {
            add = "│",
            change = "│",
            delete = "-",
          }
        },
        marks = {
          enable = true,
          show_builtins = false,
        },
        quickfix = {
          enable = true,
        }
      },
    })
  end,

  keys = {
    { "<leader>nm", "<cmd>lua require('satellite').toggle()<cr>", desc = "Toggle Scrollbar" },
  },
}
