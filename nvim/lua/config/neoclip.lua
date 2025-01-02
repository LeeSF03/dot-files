local neoclip = require('neoclip')

neoclip.setup({
  history = 1000,
  enable_persistent_history = false,
  length_limit = 1048576,
  continuous_sync = false,
  db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
  filter = nil,
  preview = true,
  prompt = nil,
  default_register = '"',
  default_register_macros = 'q',
  enable_macro_history = true,
  content_spec_column = false,
  disable_keycodes_parsing = false,
  on_select = {
    move_to_front = false,
    close_telescope = true,
  },
  on_paste = {
    set_reg = false,
    move_to_front = false,
    close_telescope = true,
  },
  on_replay = {
    set_reg = false,
    move_to_front = false,
    close_telescope = true,
  },
  on_custom_action = {
    close_telescope = true,
  },
  keys = {
    telescope = {
      i = {
        select = false,
        paste = '<CR>',
        paste_behind = '<S-CR>',
        replay = false,  -- replay a macro
        delete = false,  -- delete an entry
        edit = false,  -- edit an entry
        custom = {},
      },
      n = {
        select = '<CR>',
        paste = 'p',
        --- It is possible to map to more than one key.
        -- paste = { 'p', '<c-p>' },
        paste_behind = 'P',
        replay = 'q',
        delete = 'd',
        edit = 'e',
        custom = {},
      },
    },
    fzf = {
      select = 'default',
      paste = 'ctrl-p',
      paste_behind = 'ctrl-k',
      custom = {},
    },
  },
})

