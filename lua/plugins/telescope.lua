return {
  'nvim-telescope/telescope.nvim',
  tag = 'v0.2.0',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install'
    },
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      version = "^1.0.0",
    },
  },
  config = function()
    local telescope = require('telescope')
    local lga_actions = require("telescope-live-grep-args.actions")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-a>"] = { "<Home>", type = "command" },
            ["<C-e>"] = { "<End>", type = "command" },
            ["<C-l>"] = { "<C-u>", type = "command" },
          }
        }
      },
      extensions = {
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          -- define mappings, e.g.
          mappings = {         -- extend mappings
            i = {
              ["<C-k>"] = lga_actions.quote_prompt(),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              -- freeze the current list and start a fuzzy search in the frozen list
              ["<C-space>"] = lga_actions.to_fuzzy_refine,
            },
          },
        }
      }
    })

    telescope.load_extension('fzf')
    telescope.load_extension('live_grep_args')

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })

    -- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set("n", "<leader>fg", "<Cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    vim.keymap.set('n', '<leader>fy', builtin.command_history, { desc = 'Telescope command history' })
    vim.keymap.set('n', '<leader>fq', builtin.quickfix, { desc = 'Telescope quickfix' })
    vim.keymap.set('n', '<leader>ft', builtin.colorscheme, { desc = 'Telescope find themes' })
    vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Telescope find current buffer' })

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

    vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = "Search [G]it [C]ommits" })
    vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = "Search [G]it [B]ranches" })
    vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = "Search [G]it [S]tatus" })
    vim.keymap.set('n', '<leader>gS', builtin.git_stash, { desc = "Search [G]it [S]tash" })
  end
}
