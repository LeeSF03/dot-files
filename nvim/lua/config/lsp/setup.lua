local mason = require("mason")
local masontoolinstaller = require("mason-tool-installer")
local masonlsp = require("mason-lspconfig")

mason.setup({
  ui = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  }
})

-- list of tools(linters, formatters, etc):
-- https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters
-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
masontoolinstaller.setup({
  ensure_installed = {
    -- web
    "prettier",
    "prettierd",
    "eslint_d",

    -- golang
    "gofumpt",
    "golines",

    -- python
    "ruff",
  },
})

-- list of language servers: https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
masonlsp.setup({
  ensure_installed = {
    -- lua
    "lua_ls",

    -- python
    "basedpyright",

    -- web
    "ts_ls",
    "tailwindcss",
    "cssmodules_ls",
    "biome",
    "yamlls",

    -- docker
    "docker_compose_language_service",
    "dockerls",

    -- golang
    "gopls",

    -- php
    "intelephense",
    "phpactor",

    -- c++
    "clangd",

    -- c#
    "omnisharp",

    -- nginx
    "nginx_language_server",
  },
})

-- Disable diagnostic signs
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    }
  }
})

local orig_util = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  return orig_util(contents, syntax, opts, ...)
end

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#89b4fa", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#1e1e2e" })
