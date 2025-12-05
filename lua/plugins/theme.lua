return {
  {
    "folke/tokyonight.nvim",
    lazy = false, -- Load immediately on startup
    priority = 1000, -- Load before everything else
    config = function()
      -- This function runs after the plugin is loaded
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  }
}
