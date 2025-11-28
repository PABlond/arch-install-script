-- Configuration de Supermaven
-- Fichier: ~/.config/nvim/lua/plugins/supermaven.lua

return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<Tab>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
      ignore_filetypes = { "markdown", "text" },
      color = { suggestion_color = "#7aa2f7", cterm = 244 },
      log_level = "info",
      disable_inline_completion = false,
      disable_keymaps = false,
    })

    -- Intégration avec nvim-cmp
    local cmp = require("cmp")
    cmp.setup({
      sources = cmp.config.sources({
        { name = "supermaven" }, -- Ajouter Supermaven comme source
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end,
}
