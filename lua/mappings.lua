-- Set the Leader key to Space
-- This must happen before plugins are loaded (otherwise some plugins might default to backslash)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
map("n", "]q", ":cnext<CR>", { desc = "Next Quickfix Item" })
map("n", "[q", ":cprev<CR>", { desc = "Previous Quickfix Item" })

-- LOCATION LIST NAVIGATION
map("n", "]l", ":lnext<CR>", { desc = "Next Location Item" })
map("n", "[l", ":lprev<CR>", { desc = "Previous Location Item" })

map('n', 'gK',
  function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end
  , { desc = "Toggle diagnostics virtual_text" })
