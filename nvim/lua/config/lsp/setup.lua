local mason = require("mason")
local masontoolinstaller = require("mason-tool-installer")
local masonlsp = require("mason-lspconfig")
local blink = require("blink.cmp")
local telescope_builtin = require("telescope.builtin")

mason.setup()

-- list of tools(linters, formatters, etc):
-- https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters
-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
masontoolinstaller.setup({
  ensure_installed = {
    "prettier",
    "prettierd",
    "eslint_d",
  },
})

-- list of language servers: https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
masonlsp.setup({
  ensure_installed = {
    "lua_ls",
    "ts_ls",
    "tailwindcss",
    "cssmodules_ls",
    "docker_compose_language_service",
    "dockerls",
  }
})

blink.setup({
  keymap = {
    ['<C-s>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide' },
    ['<C-y>'] = { 'select_and_accept' },

    -- ['<C-k>'] = { 'select_prev', 'fallback' },
    -- ['<C-j>'] = { 'select_next', 'fallback' },

    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono',
  },
  completion = {
    menu = {
      border = 'rounded',
    },
    documentation = {
      window = {
        border = 'rounded',
      },
      auto_show = true,
      auto_show_delay_ms = 500,
    },
  },
  -- experimental signature help support
  signature = { enabled = true, window = { border = 'rounded' } },
})


vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local lspsaga = require('lspsaga')
    lspsaga.setup({
      code_action = {
        keys = {
          quit = 'q',
          exec = '<CR>',
        }
      },
      rename = {
        keys = {
          quit = 'q',
        }
      },
      definition = {
        keys = {
          quit = 'q',
        }
      }
    })

    -- Disabled because using blink.cmp
    -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    vim.keymap.set('n', 'ghh', '<cmd>Lspsaga hover_doc<CR>', { desc = "Hover action from LSP", buffer = ev.buf })
    vim.keymap.set('n', 'ghe', '<cmd>Lspsaga hover_doc ++<CR>', { desc = "Enter hover", buffer = ev.buf })

    vim.keymap.set('n', 'gsc', '<cmd>Lspsaga show_cursor_diagnostics<CR>',
      { desc = "Show cursor diagnostics", buffer = ev.buf })
    vim.keymap.set('n', 'gsw', '<cmd>Lspsaga show_workspace_diagnostics<CR>',
      { desc = "Show workplace diagnostics", buffer = ev.buf })
    vim.keymap.set('n', 'gsh', '<cmd>Lspsaga diagnostic_jump_prev<CR>',
      { desc = "Jump to previous diagnostic", buffer = ev.buf })
    vim.keymap.set('n', 'gsl', '<cmd>Lspsaga diagnostic_jump_next<CR>',
      { desc = "Jump to next diagnostic", buffer = ev.buf })

    vim.keymap.set('n', 'gdp', '<cmd>Lspsaga peek_definition<CR>', { desc = "Peek defenition", buffer = ev.buf })
    vim.keymap.set('n', 'gdo', '<cmd>Lspsaga goto_definition<CR>', { desc = "Go to defenition", buffer = ev.buf })

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = ev.buf })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation", buffer = ev.buf })
    vim.keymap.set('n', 'gr', telescope_builtin.lsp_references, { desc = "Go to references", buffer = ev.buf })
    vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', { desc = "Rename variable", buffer = ev.buf })
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<CR>', { desc = "Code Actions", buffer = ev.buf })
    vim.keymap.set('n', '<leader>cf', function()
      vim.lsp.buf.format { async = true }
    end, { desc = "Code Format", buffer = ev.buf })
  end
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

-- Set autocomplete highlight
vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "#1e1e2e", })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#89b4fa", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = "#ea76cb" })
vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = "#1e1e2e", })
vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { fg = "#89b4fa", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#89b4fa", bg = "#1e1e2e" }) -- not working
