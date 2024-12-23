local nvimtree = require("nvim-tree")

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.5  -- You can change this too

nvimtree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  sync_root_with_cwd = true,
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2)
                         - vim.opt.cmdheight:get()
        return {
          border = "rounded",
          relative = "editor",
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
        end,
    },
    width = function()
      return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
    end,
  },
  renderer = {
    indent_markers = {
      enable = true,
      inline_arrows = false,
    },
    icons = {
      glyphs = {
        folder = {
          arrow_closed = "",
          arrow_open = "",
        },
        git = {
          unstaged = "󰐕",
          untracked = "?",
        },
      },
    },
  },
  -- filters = {
  --   custom = { "^.git$" },
  -- },
})

vim.keymap.set('n', '<C-n>', '<cmd>:NvimTreeFindFileToggle<CR>', { desc = 'Toggle Tree with local file opened' })
