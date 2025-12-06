-- This must happen before plugins are loaded (otherwise some plugins might default to backslash)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local group = vim.api.nvim_create_augroup("MyMappings", { clear = true })

local map = vim.keymap.set

map('n', '<leader>w', '<Cmd>write<CR>', { desc = 'Save file' })
map('n', '<leader>q', '<Cmd>quit<CR>', { desc = 'Quit' })

map('n', '<Esc>', '<Cmd>nohlsearch<CR>')

map('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })


map('n', '<leader>t', '<Cmd>terminal<CR>', { desc = 'Open Neovim terminal' })
map('t', '<leader>c', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Lua modules are cached, it only reloads changes in init.lua
map('n', '<leader>so', '<Cmd>source $MYVIMRC<CR>', { desc = 'Load changes made to init.lua' })

map('n', '<leader>bp', '<Cmd>bprev<CR>', { desc = 'Show previous buffer' })
map('n', '<leader>bn', '<Cmd>bnext<CR>', { desc = 'Show next buffer' })

-- QUICKFIX NAVIGATION
map("n", "]q", "<Cmd>cnext<CR>", { desc = "Next Quickfix Item" })
map("n", "[q", "<Cmd>cprev<CR>", { desc = "Previous Quickfix Item" })

map("n", "<leader>qa", function()
  local item = {
    filename = vim.fn.expand("%"),
    lnum = 1,
    col = 1,
    text = vim.api.nvim_get_current_line()
  }

  vim.fn.setqflist({}, 'a', { items = { item } })
end, { desc = "[Q]uickfix [A]dd Item" })

-- Navigation through the Quickfix History
map("n", "<leader>qn", "<Cmd>cnewer<CR>", { desc = "[Q]uickfix [N]ext" })
map("n", "<leader>qp", "<Cmd>colder<CR>", { desc = "[Q]uickfix [P]revious" })
-- It doesn't actually clear the qf list, it adds an empty one on top
-- of the ql stack
map("n", "<leader>qc", "<Cmd>cexpr []<CR>", { desc = "[Q]uickfix [C]lear" })
map("n", "<leader>qh", "<Cmd>chi<CR>", { desc = "[Q]uickfix [H]history" })

-- Remove an item from a qf list
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  group = group,
  callback = function(event)
    vim.keymap.set("n", "dd", function()
      local is_qf = vim.fn.getwininfo(vim.fn.win_getid())[1].quickfix == 1
      local list = is_qf and vim.fn.getqflist() or vim.fn.getloclist(0)
      local lnum = vim.fn.line('.')

      table.remove(list, lnum)

      if is_qf then
        vim.fn.setqflist(list, 'r')
      else
        vim.fn.setloclist(0, list, 'r')
      end

      -- Restore cursor position (otherwise it jumps to the top)
      vim.cmd('normal! ' .. lnum .. 'G')
    end, { buffer = event.buf, silent = true })
  end,
})

-- LOCATION LIST NAVIGATION
map("n", "]l", "<Cmd>lnext<CR>", { desc = "Next Location Item" })
map("n", "[l", "<Cmd>lprev<CR>", { desc = "Previous Location Item" })

map('n', 'gK',
  function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end
  , { desc = "Toggle diagnostics virtual_text" })
