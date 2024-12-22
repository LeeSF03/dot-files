local mason = require("mason")
local masonlsp = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local blink = require("blink.cmp")
local capabilities = blink.get_lsp_capabilities()

mason.setup()

vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "#181825", })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#89b4fa", bg = "#181825" })
vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = "#ea76cb" })
vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = "#181825", })
vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { fg = "#89b4fa", bg = "#181825" })
vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#89b4fa", bg = "#181825" }) -- not working

blink.setup({
  keymap = {
    ['<C-s>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide' },
    ['<C-y>'] = { 'select_and_accept' },

    ['<C-k>'] = { 'select_prev', 'fallback' },
    ['<C-j>'] = { 'select_next', 'fallback' },

    ['<C-h>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-l>'] = { 'scroll_documentation_down', 'fallback' },
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

-- list of language servers: https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
masonlsp.setup({
  ensure_installed = {
    "lua_ls",
    "ts_ls"
  }
})

-- lua language server setup
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  }
})

-- typescript language server setup
lspconfig.ts_ls.setup({
  capabilities = capabilities,
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

    vim.keymap.set('n', 'gsc', '<cmd>Lspsaga show_cursor_diagnostics<CR>', { desc = "Show cursor diagnostics", buffer = ev.buf })
    vim.keymap.set('n', 'gsw', '<cmd>Lspsaga show_workspace_diagnostics<CR>', { desc = "Show workplace diagnostics", buffer = ev.buf })
    vim.keymap.set('n', 'gsh', '<cmd>Lspsaga diagnostic_jump_prev<CR>', { desc = "Jump to previous diagnostic", buffer = ev.buf })
    vim.keymap.set('n', 'gsl', '<cmd>Lspsaga diagnostic_jump_next<CR>', { desc = "Jump to next diagnostic", buffer = ev.buf })

    vim.keymap.set('n', 'gdp', '<cmd>Lspsaga peek_definition<CR>', { desc = "Peek defenition", buffer = ev.buf })
    vim.keymap.set('n', 'gdo', '<cmd>Lspsaga goto_definition<CR>', { desc = "Go to defenition", buffer = ev.buf })

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = ev.buf })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation", buffer = ev.buf })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "Go to references", buffer = ev.buf })
    vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', { desc = "Rename variable", buffer = ev.buf })
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<CR>', { desc = "Code Actions", buffer = ev.buf })
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, { desc = "Format code", buffer = ev.buf })
  end
})
