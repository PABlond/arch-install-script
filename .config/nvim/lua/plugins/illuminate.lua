-- Configuration de vim-illuminate
-- Surligne automatiquement les occurrences du mot sous le curseur
-- Fichier: ~/.config/nvim/lua/plugins/illuminate.lua

return {
  "RRethy/vim-illuminate",
  lazy = false,
  config = function()
    require("illuminate").configure({
      providers = {
        'lsp',
        'treesitter',
        'regex',
      },
      delay = 100,
      filetype_overrides = {},
      filetypes_denylist = {
        'dirvish',
        'fugitive',
        'NvimTree',
        'TelescopePrompt',
        'lazy',
      },
      under_cursor = true,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
      min_count_to_highlight = 1,
    })

    -- Définir des couleurs de surlignage style Tokyo Night
    local function set_illuminate_colors()
      -- Couleurs Tokyo Night (bleu/cyan pour visibilité)
      vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#7aa2f7", fg = "#24283b", bold = true })  -- Bleu Tokyo Night
      vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#7aa2f7", fg = "#24283b", bold = true })  -- Bleu Tokyo Night
      vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#7dcfff", fg = "#24283b", bold = true })  -- Cyan Tokyo Night
    end

    -- Appliquer après le chargement du thème
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = set_illuminate_colors,
    })

    -- Appliquer immédiatement
    set_illuminate_colors()

    -- Désactiver illuminate en mode visuel pour voir la sélection
    vim.api.nvim_create_autocmd("ModeChanged", {
      pattern = "*",
      callback = function()
        local mode = vim.fn.mode()
        if mode == "v" or mode == "V" or mode == "\22" then  -- \22 = CTRL-V (visual block)
          require('illuminate').pause()
        else
          require('illuminate').resume()
        end
      end,
    })

    -- Raccourcis pour naviguer entre les occurrences surlignées
    vim.keymap.set('n', ']]', function() require('illuminate').goto_next_reference(false) end, { desc = "Next Reference" })
    vim.keymap.set('n', '[[', function() require('illuminate').goto_prev_reference(false) end, { desc = "Prev Reference" })

    -- Commande pour tester illuminate
    vim.api.nvim_create_user_command('IlluminateTest', function()
      local illuminate = require('illuminate')
      print("Illuminate loaded: " .. tostring(illuminate ~= nil))
      print("Illuminate paused: " .. tostring(require('illuminate.engine').is_paused()))

      -- Afficher les highlight groups
      local hl_text = vim.api.nvim_get_hl(0, { name = "IlluminatedWordText" })
      local hl_read = vim.api.nvim_get_hl(0, { name = "IlluminatedWordRead" })
      local hl_write = vim.api.nvim_get_hl(0, { name = "IlluminatedWordWrite" })

      print("IlluminatedWordText: " .. vim.inspect(hl_text))
      print("IlluminatedWordRead: " .. vim.inspect(hl_read))
      print("IlluminatedWordWrite: " .. vim.inspect(hl_write))
    end, {})
  end,
}
