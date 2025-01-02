local smartsplits = require('smart-splits')

smartsplits.setup()

-- resize splits
vim.keymap.set({ 'n', 't' }, '<A-h>', function() smartsplits.resize_left(1) end, { desc = 'resize to left' })
vim.keymap.set({ 'n', 't' }, '<A-j>', function() smartsplits.resize_down(1) end, { desc = 'resize to down' })
vim.keymap.set({ 'n', 't' }, '<A-k>', function() smartsplits.resize_up(1) end, { desc = 'resize to up' })
vim.keymap.set({ 'n', 't' }, '<A-l>', function() smartsplits.resize_right(1) end, { desc = 'resize to right' })

-- moving between splits
-- the letters are capital even with shift because of wezterm
vim.keymap.set({ 'n', 't' }, "<C-h>", smartsplits.move_cursor_left, { desc = 'move cursor left' })
vim.keymap.set({ 'n', 't' }, "<C-j>", smartsplits.move_cursor_down, { desc = 'move cursor down' })
vim.keymap.set({ 'n', 't' }, "<C-k>", smartsplits.move_cursor_up, { desc = 'move cursor up' })
vim.keymap.set({ 'n', 't' }, "<C-l>", smartsplits.move_cursor_right, { desc = 'move cursor right' })
