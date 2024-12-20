-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
    side = "right",
  },
  renderer = {
    group_empty = true,
  },
  actions = {
    open_file = {
      quit_on_open = true
    }
  }
})

vim.keymap.set('n', '<C-n>', '<cmd>:NvimTreeFindFileToggle<CR>', { desc = 'Toggle Tree with local file opened' })
