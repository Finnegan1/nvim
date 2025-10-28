return { -- LLMs
  'olimorris/codecompanion.nvim',
  version = '*',
  enabled = true,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('config.codecompanion')
  end,
}
