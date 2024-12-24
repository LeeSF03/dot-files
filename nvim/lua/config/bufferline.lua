local bufferline = require('bufferline')

bufferline.setup()

vim.keymap.set('n', '<leader>]', '<cmd>BufferLineCycleNext<CR>', { desc = 'Switch to next buffer' })
vim.keymap.set('n', '<leader>[', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Switch to previous buffer' })
vim.keymap.set('n', '<leader>}', '<cmd>BufferLineMoveNext<CR>', { desc = 'Swap with next buffer' })
vim.keymap.set('n', '<leader>{', '<cmd>BufferLineMovePrev<CR>', { desc = 'Swap with previous buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Delete current buffer' })
vim.keymap.set('n', '<leader>bn', '<cmd>:enew<CR>', { desc = 'Create new unname buffer' })
