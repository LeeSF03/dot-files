return {
  'akinsho/git-conflict.nvim',
  version = "*",
  config = true,
  event = "BufReadPost",
  enabled = false,
  -- TODO: add keymaps for git conflicts cmd - GitConflictChooseOurs, GGitConflictChooseTheirs, etc.
}
