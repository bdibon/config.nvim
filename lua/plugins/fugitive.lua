return {
  "tpope/vim-fugitive",
  dependencies = {
    "tpope/vim-rhubarb"
  },
  config = function()
    vim.keymap.set("n", "<leader>go", "<Cmd>GBrowse<CR>", { desc = "[G]it [O]pen in browser" })
    vim.keymap.set("v", "<leader>go", "<Esc><Cmd>'<,'>GBrowse<CR>", { desc = "[G]it [O]pen in browser" })
    vim.keymap.set("v", "<leader>gy", "<Cmd>GBrowse!<CR>", { desc = "[G]it [Y]ank link" })
    vim.keymap.set("n", "<leader>gy", "<Cmd>GBrowse!<CR>", { desc = "[G]it [Y]ank link" })
  end
}
