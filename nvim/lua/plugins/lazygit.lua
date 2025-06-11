-- nvim v0.8.0
return {
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    init = function()
      vim.api.nvim_set_hl(0, "LazyGitBorder", { fg = "#585b70" })
    end
  },
  -- {
  --   -- Open files and command output from wezterm, kitty, and neovim terminals in
  --   -- your current neovim instance
  --   -- https://github.com/willothy/flatten.nvim
  --   "willothy/flatten.nvim",
  --
  --   -- Ensure that it runs first to minimize delay when opening file from terminal
  --   lazy = false,
  --   priority = 1001,
  --   -- enabled = true,
  --   config = true,
  --   opts = {
  --       window = {
  --         open = "alternate",
  --       },
  --       -- integrations = {
  --       --   wezterm = true,
  --       -- },
  --     }
  -- },
}
