return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  config = function()
    require("oil").setup({
        delete_to_trash = true,
        watch_for_changes = true,
        view_options = {
            show_hidden = true,
        }
    })
  end,
  dependencies = {
	 -- { 'echasnovski/mini.icons'},
      --{ 
          "nvim-tree/nvim-web-devicons" 
      --}
    },
}
