local bufferline = require('bufferline')

bufferline.setup()

vim.keymap.set('n', '<leader>]', '<cmd>BufferLineCycleNext<CR>', { desc = 'Switch to next buffer' })
vim.keymap.set('n', '<leader>[', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Switch to previous buffer' })
vim.keymap.set('n', '<leader>bd', ':bdelete<cr>', { desc = 'Delete current buffer' })
