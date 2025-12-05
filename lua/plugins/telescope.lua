return {
  'nvim-telescope/telescope.nvim',
  tag = 'v0.2.0',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install'
    },
  },
  config = function()
    require('telescope').setup({})
    require('telescope').load_extension('fzf');

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

    vim.keymap.set('n', '<leader>fd', function()
      builtin.diagnostics({ bufnr = 0 })
    end, {
      desc = "[F]ind [D]iagnostics (current file)"
    })


    -- Diagnostics with most LSP are lazy loaded, so only opened files diagnostics
    -- will be shown.
    vim.keymap.set('n', '<leader>fD', builtin.diagnostics, {
      desc = "[F]ind [D]iagnostics (workspace)"
    })

    vim.keymap.set('n', '<leader>fc', function()
      builtin.find_files {
        cwd = vim.fn.stdpath('config')
      }
    end)

    vim.keymap.set('n', '<leader>fp', function()
      builtin.find_files({
        cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy')
      })
    end)
  end
}
