local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Telescope commands' })
vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Telescope find git tracked files' })
vim.keymap.set('n', '<leader>fm', "<CMD>Telescope marks mark_type=local<CR>", { desc = 'Telescope find marks' })
vim.keymap.set('n', '<leader>fd', "<CMD>Telescope diagnostics<CR>", { desc = 'Telescope find diagnostics' })
vim.keymap.set('n', '<leader>ft', "<CMD>TodoTelescope<CR>", { desc = 'Telescope find todos' })

local telescope = require("telescope")
local actions = require("telescope.actions")
telescope.setup {
  pickers = {
    find_files = {
      hidden = true,
      -- find_command = { "fd", "--type", "f", "--no-ignore", "--hidden" },
      find_command = { "fd", "--type", "f", "--hidden" },
    },
    live_grep = {
      additional_args = function()
        return { "--hidden" }
      end,
    },
  },
  defaults = {
    previewer = true,
    file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,
    layout_startegy = 'horizontal',
    -- file_ignore_patterns = {
    --   "node_modules",
    --   ".git/*",
    --   "%.venv",
    --   "%venv",
    --   "%.next",
    -- },
    layout_config = {
      center = {
        height = 0.80,
        preview_cutoff = 1,
        prompt_position = "top",
        width = 0.80
      },
      horizontal = {
        preview_cutoff = 1,
        prompt_position = "bottom",
      },
    },
    mappings = {
      i = {
        -- ["<C-j>"] = actions.move_selection_next,
        -- ["<C-k>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        -- ["<C-x>"] = actions.delete_buffer,
      }
    }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      },
    },
  }
}

telescope.load_extension("ui-select")
