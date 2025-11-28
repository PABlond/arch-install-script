-- Configuration des diagnostics LSP
-- Fichier: ~/.config/nvim/lua/config/diagnostics.lua

vim.diagnostic.config({
  virtual_text = {
    -- Limiter la longueur du texte virtuel
    prefix = "●",
    spacing = 4,
    severity_sort = true,
  },
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Afficher automatiquement les diagnostics dans une fenêtre flottante au hover
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})
