-- Configuration de gemini.nvim
-- Fichier: ~/.config/nvim/lua/plugins/gemini.lua

return {
  "kiddos/gemini.nvim",
  build = { "pip install -r requirements.txt", ":UpdateRemotePlugins" },
  config = function()
    require("gemini").setup({
      model_config = {
        model_id = "gemini-1.5-flash", -- Modèle stable pour clé gratuite
        temperature = 0.2,
        max_output_tokens = 4096,
        response_mime_type = "text/plain",
      },
      chat_config = {
        enabled = true,
      },
      hints = {
        enabled = true,
        hints_delay = 2000,
        insert_result_key = "<S-Tab>",
      },
      completion = {
        enabled = true,
        blacklist_filetypes = { "help", "qf", "json", "yaml", "toml" },
        blacklist_filenames = { ".env" },
        completion_delay = 600,
        insert_result_key = "<S-Tab>",
      },
      instruction = {
        enabled = true,
        menu_key = "<C-o>",
        prompts = {
          {
            name = "Unit Test",
            command_name = "GeminiUnitTest",
            menu = "Unit Test 🚀",
          },
          {
            name = "Code Review",
            command_name = "GeminiCodeReview",
            menu = "Code Review 📜",
          },
          {
            name = "Code Explain",
            command_name = "GeminiCodeExplain",
            menu = "Code Explain",
          },
        },
      },
    })
  end,
}
