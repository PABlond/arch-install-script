-- Configuration du formatage
-- Fichier: ~/.config/nvim/lua/plugins/formatting.lua

return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting

    null_ls.setup({
      sources = {
        formatting.prettier.with({
          filetypes = {
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "css",
            "scss",
            "html",
            "json",
            "yaml",
            "markdown",
            "graphql",
          },
          -- Utiliser la configuration locale du projet si elle existe
          prefer_local = "node_modules/.bin",
        }),
        formatting.clang_format.with({
          filetypes = { "c", "cpp", "objc", "objcpp" },
        }),
      },
      -- Format au sauvegarde
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          -- Format automatiquement à la sauvegarde
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ 
                bufnr = bufnr,
                filter = function(client)
                  -- Utiliser uniquement null-ls pour le formatage
                  return client.name == "null-ls"
                end
              })
            end,
          })

          -- Ajouter un keymap pour le formatage manuel
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({
              bufnr = bufnr,
              filter = function(client)
                return client.name == "null-ls"
              end
            })
          end, { buffer = bufnr, desc = "Format buffer" })
        end
      end,
    })
  end,
} 