local lint = require("lint")

-- Available Linters: https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters
lint.linters_by_ft = {
  typescript = { "eslint" },
  javascript = { "eslint" },
  typescriptreact = { "eslint" },
  javascriptreact = { "eslint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})
