return {
  {
    'lewis6991/gitsigns.nvim',
    keys = {
      { "gp", "<CMD>Gitsigns preview_hunk<CR>", desc = "Git Preview Hunk", mode = "n" },
    },
    opts = {
      current_line_blame = true,
      signs = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signs_staged = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
    },
    event = {
      'BufReadPost',
      'BufNewFile'
    },
  }
}
