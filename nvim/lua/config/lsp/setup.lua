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
    "prettier",
    "prettierd",
    "eslint_d",
    -- "golangcilint",
    "gofumpt",
    "golines",
  },
})

-- list of language servers: https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
masonlsp.setup({
  ensure_installed = {
    -- lua
    "lua_ls",

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
