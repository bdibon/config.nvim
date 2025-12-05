return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { 
          "lua", "vim", "vimdoc", 
          "javascript", "typescript", "tsx",
          "html", "css", "json" 
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Highlight module: "Enable syntax highlighting"
        highlight = {
          enable = true, -- false will disable the whole extension
          
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          additional_vim_regex_highlighting = false,
        },

        -- Indentation module: "Enable smart indentation"
        indent = {
          enable = true,
        },
      })
    end,
  }
}
