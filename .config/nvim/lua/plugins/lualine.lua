-- Configuration de Lualine
-- Fichier: ~/.config/nvim/lua/plugins/lualine.lua

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    require("lualine").setup({
      options = {
        theme = "tokyonight",
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '', right = ''},
        globalstatus = true, -- Statusline unique pour toutes les fenêtres
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {
          {
            'filename',
            path = 1, -- 0 = juste nom, 1 = chemin relatif, 2 = chemin absolu, 3 = chemin absolu avec ~
            shorting_target = 40,
            symbols = {
              modified = ' [+]',
              readonly = ' []',
              unnamed = '[No Name]',
            }
          }
        },
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            'filename',
            path = 1,
          }
        },
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
    })
  end,
}
