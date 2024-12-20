local configs = require("nvim-treesitter.configs")

--error: https://github.com/nvim-lua/kickstart.nvim/issues/123
--fixed: https://github.com/nvim-lua/kickstart.nvim/issues/123#issuecomment-2269703528
require('nvim-treesitter.install').compilers = {"zig", "clang", "gcc"}

---@diagnostic disable-next-line: missing-fields
configs.setup({
  ensure_installed = { "c", "lua", "javascript", "html" },
  highlight = { enable = true },
  indent = { enable = true },  
})
