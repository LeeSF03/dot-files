local mason = require("mason")
local masonlsp = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local capabilities = require('blink.cmp').get_lsp_capabilities()

mason.setup()

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
          quit = '<esc>',
          exec = '<CR>',
        }
      },
      rename = {
        keys = {
          quit = '<esc>',
        }
      },
      definition = {
        keys = {
          quit = '<esc>',
        }
      }
    })

    -- Disabled because using blink.cmp
    -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    vim.keymap.set('n', 'gh', '<cmd>Lspsaga hover_doc<CR>', { desc = "Hover action from LSP", buffer = ev.buf })
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
