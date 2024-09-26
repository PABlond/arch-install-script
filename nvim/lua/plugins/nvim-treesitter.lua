return {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
        require('nvim-treesitter.configs').setup({
          -- for syntax-highlight, instead of regular expressions, use tree-sitter:
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
        })
      end,
    }
 
