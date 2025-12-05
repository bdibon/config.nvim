return {
  'nvim-mini/mini.nvim', version = '*',
  config = function()
    require('mini.statusline').setup({ use_icons = true })
    require('mini.surround').setup({})
  end
}

