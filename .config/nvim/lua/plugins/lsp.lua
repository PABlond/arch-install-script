-- Configuration de LSP et autocomplétion
-- Fichier: ~/.config/nvim/lua/plugins/lsp.lua

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
    { "folke/neodev.nvim", opts = {} },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- Désactiver temporairement les avertissements de dépréciation
    local notify = vim.notify
    local deprecate = vim.deprecate

    vim.notify = function(msg, level, opts)
      if type(msg) == "string" and msg:match("lspconfig.*deprecated") then
        return
      end
      notify(msg, level, opts)
    end

    vim.deprecate = function() end

    -- Charger lspconfig une seule fois
    local lspconfig = require("lspconfig")

    -- Configuration des signes pour les diagnostics
    local signs = {
      { name = "DiagnosticSignError", text = "✘" },
      { name = "DiagnosticSignWarn", text = "⚠" },
      { name = "DiagnosticSignHint", text = "💡" },
      { name = "DiagnosticSignInfo", text = "ℹ" },
    }

    for _, sign in ipairs(signs) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    -- Configuration des diagnostics
    vim.diagnostic.config({
      virtual_text = true,
      signs = { active = signs },
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      float = {
        focused = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- Configuration des gestionnaires LSP
    local handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
    }

    -- Fonction pour détecter si nous sommes dans un conteneur
    local function is_in_container()
      return vim.fn.filereadable("/.dockerenv") == 1
    end

    -- Fonction pour obtenir le chemin Python dans le conteneur
    local function get_container_python_path()
      if is_in_container() then
        -- Essayer de trouver le Python dans le conteneur
        local python_paths = {
          "/usr/local/bin/python",
          "/usr/bin/python3",
          "/usr/bin/python",
        }
        for _, path in ipairs(python_paths) do
          if vim.fn.executable(path) == 1 then
            return path
          end
        end
      end
      return nil
    end

    -- Fonction pour organiser les imports TypeScript/JavaScript
    local function organize_imports()
      local bufnr = vim.api.nvim_get_current_buf()
      local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
      
      if filetype == "typescript" or filetype == "javascript" or filetype == "typescriptreact" or filetype == "javascriptreact" then
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = ""
        }
        vim.lsp.buf_request_sync(0, "workspace/executeCommand", params, 1000)
      end
    end

    -- Configuration des serveurs LSP
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      },
      pyright = {
        settings = {
          python = {
            pythonPath = get_container_python_path(),
            analysis = {
              typeCheckingMode = "off",
              autoImportCompletions = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
              extraPaths = {
                "/workspace",
                "/home/vscode",
                vim.env.HOME,
              },
              exclude = {
                "**/__pycache__",
                "**/migrations/**",
                "**/tests/**"
              },
            },
          },
        },
      },
      ts_ls = {
        init_options = {
          preferences = {
            importModuleSpecifierPreference = "relative",
          },
        },
        settings = {
          typescript = {
            format = {
              enable = true,
              insertSpaceAfterCommaDelimiter = true,
              insertSpaceAfterSemicolonInForStatements = true,
              insertSpaceBeforeAndAfterBinaryOperators = true,
              insertSpaceAfterKeywordsInControlFlowStatements = true,
              insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
              insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
              insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = true,
              insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = true,
            },
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            format = {
              enable = true,
              insertSpaceAfterCommaDelimiter = true,
              insertSpaceAfterSemicolonInForStatements = true,
              insertSpaceBeforeAndAfterBinaryOperators = true,
              insertSpaceAfterKeywordsInControlFlowStatements = true,
              insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
              insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
              insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = true,
              insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = true,
            },
          },
        },
        commands = {
          OrganizeImports = {
            organize_imports,
            description = "Organize Imports"
          }
        },
      },
      rust_analyzer = {},
      gopls = {},
      clangd = {},
    }

    -- Configuration des capacités LSP
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- Configuration de Mason
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "ts_ls", "pyright", "rust_analyzer", "gopls", "clangd" },
    })

    -- Fonction d'attachement globale pour tous les serveurs LSP
    local function on_attach(client, bufnr)
      -- Organiser les imports automatiquement avant la sauvegarde pour TypeScript/JavaScript
      if client.name == "ts_ls" then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = organize_imports,
        })
      end

      -- Raccourci pour organiser manuellement les imports
      if client.name == "ts_ls" then
        vim.keymap.set("n", "<leader>oi", organize_imports, { buffer = bufnr, desc = "Organize Imports" })
      end
    end

    -- Configuration des serveurs LSP
    for server_name, server_settings in pairs(servers) do
      local config = vim.tbl_deep_extend("force", {
        capabilities = capabilities,
        handlers = handlers,
        on_attach = on_attach,
      }, server_settings or {})

      lspconfig[server_name].setup(config)
    end

    -- Configuration de l'autocomplétion
    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "supermaven" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
    })

    -- Raccourci pour se connecter au conteneur
    vim.keymap.set("n", "<leader>dc", ":DevcontainerAttach<CR>", { desc = "Connect to Dev Container" })

    -- Restaurer les fonctions originales
    vim.notify = notify
    vim.deprecate = deprecate
  end,
}
