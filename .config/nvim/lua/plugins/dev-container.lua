-- Configuration de dev-container.nvim
-- Fichier: ~/.config/nvim/lua/plugins/dev-container.lua

return {
  "microsoft/vscode-dev-containers",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
  },
  config = function()
    -- Fonction pour obtenir la liste des conteneurs en cours d'exécution
    local function get_containers()
      local handle = io.popen("docker ps --format '{{.Names}}'")
      if not handle then
        return {}
      end
      local result = handle:read("*a")
      handle:close()
      local containers = {}
      for container in result:gmatch("[^\r\n]+") do
        table.insert(containers, container)
      end
      return containers
    end

    -- Fonction pour exécuter une commande dans le conteneur
    local function run_in_container(container, cmd)
      local full_cmd = string.format("docker exec %s %s", container, cmd)
      local handle = io.popen(full_cmd)
      if handle then
        local result = handle:read("*a")
        handle:close()
        return result:gsub("%s+$", "") -- Supprimer les espaces et retours à la ligne
      end
      return nil
    end

    -- Fonction pour obtenir les chemins Python dans le conteneur
    local function get_container_python_paths(container)
      local python_path = vim.fn.system("docker exec " .. container .. " which python3"):gsub("%s+$", "")
      local sys_path = vim.fn.system("docker exec " .. container .. " python3 -c 'import sys; print(\"\\n\".join(sys.path))'"):gsub("%s+$", "")
      local paths = {}
      for path in sys_path:gmatch("[^\r\n]+") do
        table.insert(paths, path)
      end
      return python_path, paths
    end

    -- Commande pour sélectionner un conteneur
    vim.api.nvim_create_user_command("DevcontainerSelect", function()
      local containers = get_containers()
      if #containers == 0 then
        vim.notify("Aucun conteneur en cours d'exécution", vim.log.levels.WARN)
        return
      end

      vim.ui.select(containers, {
        prompt = "Sélectionner un conteneur",
        format_item = function(item)
          return item
        end,
      }, function(choice)
        if choice then
          local python_path, python_paths = get_container_python_paths(choice)
          if python_path then
            -- Mettre à jour la configuration LSP
            local lsp_config = require("lspconfig")
            if lsp_config.pyright then
              lsp_config.pyright.setup({
                settings = {
                  python = {
                    pythonPath = python_path,
                    analysis = {
                      extraPaths = python_paths,
                    },
                  },
                },
              })
              vim.notify("LSP configuré pour utiliser Python du conteneur: " .. choice, vim.log.levels.INFO)
            end
          end
        end
      end)
    end, {})

    -- Configuration pour la détection automatique du conteneur
    vim.api.nvim_create_autocmd("BufReadPost", {
      pattern = "*.py",
      callback = function()
        if vim.g.selected_container then
          vim.notify("Using container: " .. vim.g.selected_container, vim.log.levels.INFO)
        end
      end,
    })

    -- Fonction pour vérifier la présence de fichiers Docker
    local function has_docker_files()
      local cwd = vim.fn.getcwd()
      local files = {
        { path = cwd .. "/Dockerfile", type = "dockerfile" },
        { path = cwd .. "/docker-compose.yml", type = "compose" },
        { path = cwd .. "/docker-compose.yaml", type = "compose" },
        { path = cwd .. "/.devcontainer/devcontainer.json", type = "devcontainer" },
      }
      
      for _, file in ipairs(files) do
        if vim.fn.filereadable(file.path) == 1 then
          return true, file
        end
      end
      return false, nil
    end

    -- Commande pour démarrer le conteneur
    vim.api.nvim_create_user_command("DevcontainerStart", function()
      if vim.fn.filereadable("docker-compose.yml") == 1 then
        vim.fn.system("docker-compose up -d")
        vim.notify("Conteneur démarré avec docker-compose", vim.log.levels.INFO)
      elseif vim.fn.filereadable("Dockerfile") == 1 then
        vim.fn.system("docker build -t dev-container . && docker run -d --name dev-container dev-container")
        vim.notify("Conteneur démarré avec Dockerfile", vim.log.levels.INFO)
      else
        vim.notify("Aucun fichier Docker trouvé", vim.log.levels.ERROR)
      end
    end, {})

    -- Commande pour arrêter le conteneur
    vim.api.nvim_create_user_command("DevcontainerStop", function()
      if vim.fn.filereadable("docker-compose.yml") == 1 then
        vim.fn.system("docker-compose down")
        vim.notify("Conteneur arrêté avec docker-compose", vim.log.levels.INFO)
      else
        vim.fn.system("docker stop dev-container && docker rm dev-container")
        vim.notify("Conteneur arrêté", vim.log.levels.INFO)
      end
    end, {})
  end,
}

