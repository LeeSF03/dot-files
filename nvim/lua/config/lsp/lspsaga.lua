local telescope_builtin = require("telescope.builtin")

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
      -- rename = {
      --   keys = {
      --     quit = 'q',
      --   }
      -- },
      definition = {
        keys = {
          quit = 'q',
        }
      }
    })

    -- Disabled because using blink.cmp
    -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- hover
    vim.keymap.set('n', 'ghh', '<cmd>Lspsaga hover_doc<CR>', { desc = "Hover action from LSP", buffer = ev.buf })
    vim.keymap.set('n', 'ghe', '<cmd>Lspsaga hover_doc ++<CR>', { desc = "Enter hover", buffer = ev.buf })

    -- diagnostics
    vim.keymap.set('n', 'gsc', '<cmd>Lspsaga show_cursor_diagnostics<CR>',
      { desc = "Show cursor diagnostics", buffer = ev.buf })
    vim.keymap.set('n', 'gss', '<cmd>Lspsaga show_line_diagnostics<CR>',
      { desc = "Show line diagnostics", buffer = ev.buf })
    vim.keymap.set('n', 'gsb', '<cmd>Lspsaga show_buf_diagnostics<CR>',
      { desc = "Show buffer diagnostics", buffer = ev.buf })
    vim.keymap.set('n', 'gsw', '<cmd>Lspsaga show_workspace_diagnostics<CR>',
      { desc = "Show workplace diagnostics", buffer = ev.buf })
    vim.keymap.set('n', 'gsp', '<cmd>Lspsaga diagnostic_jump_prev<CR>',
      { desc = "Jump to previous diagnostic", buffer = ev.buf })
    vim.keymap.set('n', 'gsn', '<cmd>Lspsaga diagnostic_jump_next<CR>',
      { desc = "Jump to next diagnostic", buffer = ev.buf })

    -- definition
    vim.keymap.set('n', 'gdp', '<cmd>Lspsaga peek_definition<CR>', { desc = "Peek defenition", buffer = ev.buf })
    vim.keymap.set('n', 'gdo', '<cmd>Lspsaga goto_definition<CR>', { desc = "Go to defenition", buffer = ev.buf })

    -- others
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

