-- Configuration de alpha-nvim
-- Fichier: ~/.config/nvim/lua/plugins/alpha.lua

return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Fonction pour obtenir les fichiers récents avec raccourcis
    local function get_recent_files()
      local recent_files = {}
      local oldfiles = vim.v.oldfiles
      local max_files = 9 -- jusqu'à 9 fichiers avec touches 1 à 9

      for i = 1, #oldfiles do
        if #recent_files == max_files then break end
        local file = oldfiles[i]
        -- Vérifier que le fichier est lisible et pas temporaire
        if vim.fn.filereadable(file) == 1 and not file:match("^/tmp/") then
          local short_name = vim.fn.fnamemodify(file, ":~")
          local idx = tostring(#recent_files + 1)
          table.insert(recent_files, {
            type = "button",
            val = short_name,
            on_press = function()
              vim.cmd(":e " .. file)
            end,
            opts = {
              position = "center",
              shortcut = idx,
              keymap = { "n", idx, "<cmd>e " .. file .. "<CR>", { noremap = true, silent = true } },
              cursor = 5,
              width = 50,
              align_shortcut = "right",
              hl_shortcut = "Number",
            },
          })
        end
      end

      return recent_files
    end

    -- Header
    dashboard.section.header.val = {
      [[                                                                       ]],
      [[  ██████╗  █████╗ ██████╗ ██╗ ██████╗ ███╗   ██╗██████╗              ]],
      [[  ██╔══██╗██╔══██╗██╔══██╗██║██╔═══██╗████╗  ██║██╔══██╗             ]],
      [[  ██████╔╝███████║██████╔╝██║██║   ██║██╔██╗ ██║██║  ██║             ]],
      [[  ██╔═══╝ ██╔══██║██╔══██╗██║██║   ██║██║╚██╗██║██║  ██║             ]],
      [[  ██║     ██║  ██║██████╔╝██║╚██████╔╝██║ ╚████║██████╔╝             ]],
      [[  ╚═╝     ╚═╝  ╚═╝╚═════╝ ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝              ]],
      [[                                                                       ]],
    }

    -- Boutons de base
    dashboard.section.buttons.val = {
      dashboard.button("e", "📁 New File", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "🔍 Find File", ":Telescope find_files <CR>"),
      dashboard.button("g", "🌳 File Explorer", ":NvimTreeToggle <CR>"),
      dashboard.button("c", "⚙️  Configuration", ":e $MYVIMRC <CR>"),
      dashboard.button("q", "🚪 Quit", ":qa<CR>"),
    }

    -- Section fichiers récents
    dashboard.section.recent_files = {
      type = "group",
      val = {
        {
          type = "text",
          val = "Recent Files",
          opts = {
            hl = "SpecialComment",
            shrink_margin = false,
            position = "center",
          },
        },
        { type = "padding", val = 1 },
        {
          type = "group",
          val = get_recent_files(),
          opts = {
            shrink_margin = false,
          },
        },
      },
    }

    -- Footer
    dashboard.section.footer.val = {
      "Welcome to Neovim!",
    }

    -- Définir le layout
    dashboard.config.layout = {
      { type = "padding", val = 1 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 2 },
      dashboard.section.recent_files,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }

    dashboard.config.opts.noautocmd = true
    alpha.setup(dashboard.config)

    -- Masquer la statusline pendant Alpha
    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      callback = function()
        vim.cmd([[
          set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
        ]])
      end,
    })

    -- Lancer Alpha automatiquement si aucun fichier en argument
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        if vim.fn.argc() == 0 then
          vim.cmd("Alpha")
        end
      end,
    })
  end,
}

