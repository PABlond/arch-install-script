-- Configuration du thème Tokyo Night
-- Fichier: ~/.config/nvim/lua/plugins/cyberdream.lua

return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "storm", -- storm, moon, night, day
      light_style = "day",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      sidebars = { "qf", "help", "terminal", "packer" },
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = false,

      on_colors = function(colors)
        -- Personnalisation des couleurs si besoin
      end,

      on_highlights = function(highlights, colors)
        -- Illuminate integration
        highlights.IlluminatedWordText = { bg = colors.blue, fg = colors.bg }
        highlights.IlluminatedWordRead = { bg = colors.blue, fg = colors.bg }
        highlights.IlluminatedWordWrite = { bg = colors.cyan, fg = colors.bg }

        -- Curseur jaune/doré avec caractère en rouge vif
        highlights.Cursor = { bg = "#e0af68", fg = "#ff0000", bold = true }
        highlights.lCursor = { bg = "#e0af68", fg = "#ff0000", bold = true }
        highlights.CursorIM = { bg = "#e0af68", fg = "#ff0000", bold = true }
        highlights.TermCursor = { bg = "#e0af68", fg = "#ff0000", bold = true, reverse = false }
      end,
    })

    vim.cmd.colorscheme("tokyonight-storm")
  end,
}
