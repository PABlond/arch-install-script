-- Configuration du formatage Python
-- Fichier: ~/.config/nvim/lua/plugins/python-format.lua

return {
  "psf/black",
  "pycqa/isort",
  event = "BufWritePre",
  config = function()
    -- Fonction pour formater le fichier Python
    local function format_python()
      local bufnr = vim.api.nvim_get_current_buf()
      local filename = vim.api.nvim_buf_get_name(bufnr)
      
      -- Vérifier si c'est un fichier Python
      if not filename:match("%.py$") then
        return
      end

      -- Vérifier si un conteneur est sélectionné
      local container = vim.g.selected_container
      if not container then
        vim.notify("Aucun conteneur sélectionné", vim.log.levels.WARN)
        return
      end

      -- Formater avec isort puis black
      local isort_cmd = string.format("docker exec %s isort %s", container, filename)
      local black_cmd = string.format("docker exec %s black %s", container, filename)

      vim.fn.system(isort_cmd)
      vim.fn.system(black_cmd)

      -- Recharger le buffer
      vim.cmd("e!")
    end

    -- Commande pour formater manuellement
    vim.api.nvim_create_user_command("PythonFormat", format_python, {})

    -- Formater automatiquement à la sauvegarde
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.py",
      callback = format_python,
    })
  end,
} 