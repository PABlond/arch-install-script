return {
  'm4xshen/autoclose.nvim',
  init = function()
    require('autoclose').setup {
      keys = {
        ['$'] = { escape = true, close = true, pair = '$$', disabled_filetypes = {} },
      },
    }
  end,
}
