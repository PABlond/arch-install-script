-- Configuration de Diffview.nvim
-- Diffs visuels Git side-by-side
-- Fichier: ~/.config/nvim/lua/plugins/diffview.lua

return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("diffview").setup({
      diff_binaries = false,
      enhanced_diff_hl = true,
      git_cmd = { "git" },
      use_icons = true,
      show_help_hints = true,
      watch_index = true,

      icons = {
        folder_closed = "",
        folder_open = "",
      },

      signs = {
        fold_closed = "",
        fold_open = "",
        done = "✓",
      },

      view = {
        default = {
          layout = "diff2_horizontal",
          winbar_info = true,
        },
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true,
          winbar_info = true,
        },
        file_history = {
          layout = "diff2_horizontal",
          winbar_info = true,
        },
      },

      file_panel = {
        listing_style = "tree",
        tree_options = {
          flatten_dirs = true,
          folder_statuses = "only_folded",
        },
        win_config = {
          position = "left",
          width = 35,
          win_opts = {}
        },
      },

      file_history_panel = {
        log_options = {
          git = {
            single_file = {
              diff_merges = "combined",
            },
            multi_file = {
              diff_merges = "first-parent",
            },
          },
        },
        win_config = {
          position = "bottom",
          height = 16,
          win_opts = {}
        },
      },

      commit_log_panel = {
        win_config = {
          win_opts = {},
        }
      },

      default_args = {
        DiffviewOpen = {},
        DiffviewFileHistory = {},
      },

      hooks = {},

      keymaps = {
        disable_defaults = false,
        view = {
          { "n", "<tab>",      "<cmd>lua require('diffview.actions').select_next_entry()<CR>", { desc = "Next file" } },
          { "n", "<s-tab>",    "<cmd>lua require('diffview.actions').select_prev_entry()<CR>", { desc = "Previous file" } },
          { "n", "gf",         "<cmd>lua require('diffview.actions').goto_file()<CR>", { desc = "Go to file" } },
          { "n", "<C-w><C-f>", "<cmd>lua require('diffview.actions').goto_file_split()<CR>", { desc = "Go to file (split)" } },
          { "n", "<C-w>gf",    "<cmd>lua require('diffview.actions').goto_file_tab()<CR>", { desc = "Go to file (tab)" } },
          { "n", "<leader>e",  "<cmd>lua require('diffview.actions').focus_files()<CR>", { desc = "Focus file panel" } },
          { "n", "<leader>b",  "<cmd>lua require('diffview.actions').toggle_files()<CR>", { desc = "Toggle file panel" } },
        },
        file_panel = {
          { "n", "j",             "<cmd>lua require('diffview.actions').next_entry()<CR>", { desc = "Next entry" } },
          { "n", "k",             "<cmd>lua require('diffview.actions').prev_entry()<CR>", { desc = "Previous entry" } },
          { "n", "<cr>",          "<cmd>lua require('diffview.actions').select_entry()<CR>", { desc = "Select entry" } },
          { "n", "o",             "<cmd>lua require('diffview.actions').select_entry()<CR>", { desc = "Select entry" } },
          { "n", "<2-LeftMouse>", "<cmd>lua require('diffview.actions').select_entry()<CR>", { desc = "Select entry" } },
          { "n", "-",             "<cmd>lua require('diffview.actions').toggle_stage_entry()<CR>", { desc = "Stage/unstage" } },
          { "n", "S",             "<cmd>lua require('diffview.actions').stage_all()<CR>", { desc = "Stage all" } },
          { "n", "U",             "<cmd>lua require('diffview.actions').unstage_all()<CR>", { desc = "Unstage all" } },
          { "n", "R",             "<cmd>lua require('diffview.actions').refresh_files()<CR>", { desc = "Refresh" } },
          { "n", "<tab>",         "<cmd>lua require('diffview.actions').select_next_entry()<CR>", { desc = "Next entry" } },
          { "n", "<s-tab>",       "<cmd>lua require('diffview.actions').select_prev_entry()<CR>", { desc = "Previous entry" } },
          { "n", "gf",            "<cmd>lua require('diffview.actions').goto_file()<CR>", { desc = "Go to file" } },
          { "n", "<C-w><C-f>",    "<cmd>lua require('diffview.actions').goto_file_split()<CR>", { desc = "Go to file (split)" } },
          { "n", "<C-w>gf",       "<cmd>lua require('diffview.actions').goto_file_tab()<CR>", { desc = "Go to file (tab)" } },
          { "n", "i",             "<cmd>lua require('diffview.actions').listing_style()<CR>", { desc = "Toggle listing style" } },
          { "n", "f",             "<cmd>lua require('diffview.actions').toggle_flatten_dirs()<CR>", { desc = "Flatten dirs" } },
          { "n", "<leader>e",     "<cmd>lua require('diffview.actions').focus_files()<CR>", { desc = "Focus file panel" } },
          { "n", "<leader>b",     "<cmd>lua require('diffview.actions').toggle_files()<CR>", { desc = "Toggle file panel" } },
        },
        file_history_panel = {
          { "n", "g!",            "<cmd>lua require('diffview.actions').options()<CR>", { desc = "Options" } },
          { "n", "<C-A-d>",       "<cmd>lua require('diffview.actions').open_in_diffview()<CR>", { desc = "Open in diffview" } },
          { "n", "y",             "<cmd>lua require('diffview.actions').copy_hash()<CR>", { desc = "Copy hash" } },
          { "n", "L",             "<cmd>lua require('diffview.actions').open_commit_log()<CR>", { desc = "Commit log" } },
          { "n", "zR",            "<cmd>lua require('diffview.actions').open_all_folds()<CR>", { desc = "Open all folds" } },
          { "n", "zM",            "<cmd>lua require('diffview.actions').close_all_folds()<CR>", { desc = "Close all folds" } },
          { "n", "j",             "<cmd>lua require('diffview.actions').next_entry()<CR>", { desc = "Next entry" } },
          { "n", "k",             "<cmd>lua require('diffview.actions').prev_entry()<CR>", { desc = "Previous entry" } },
          { "n", "<cr>",          "<cmd>lua require('diffview.actions').select_entry()<CR>", { desc = "Select entry" } },
          { "n", "o",             "<cmd>lua require('diffview.actions').select_entry()<CR>", { desc = "Select entry" } },
          { "n", "<2-LeftMouse>", "<cmd>lua require('diffview.actions').select_entry()<CR>", { desc = "Select entry" } },
          { "n", "<tab>",         "<cmd>lua require('diffview.actions').select_next_entry()<CR>", { desc = "Next entry" } },
          { "n", "<s-tab>",       "<cmd>lua require('diffview.actions').select_prev_entry()<CR>", { desc = "Previous entry" } },
          { "n", "gf",            "<cmd>lua require('diffview.actions').goto_file()<CR>", { desc = "Go to file" } },
          { "n", "<C-w><C-f>",    "<cmd>lua require('diffview.actions').goto_file_split()<CR>", { desc = "Go to file (split)" } },
          { "n", "<C-w>gf",       "<cmd>lua require('diffview.actions').goto_file_tab()<CR>", { desc = "Go to file (tab)" } },
          { "n", "<leader>e",     "<cmd>lua require('diffview.actions').focus_files()<CR>", { desc = "Focus file panel" } },
          { "n", "<leader>b",     "<cmd>lua require('diffview.actions').toggle_files()<CR>", { desc = "Toggle file panel" } },
        },
        option_panel = {
          { "n", "<tab>", "<cmd>lua require('diffview.actions').select_entry()<CR>", { desc = "Select entry" } },
          { "n", "q",     "<cmd>lua require('diffview.actions').close()<CR>", { desc = "Close" } },
        },
      },
    })
  end,
}
