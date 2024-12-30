local smartsplits = require('smart-splits')

smartsplits.setup()

-- resize splits
vim.keymap.set('n', '<A-h>', function() smartsplits.resize_left(1) end, { desc = 'resize to left' })
vim.keymap.set('n', '<A-j>', function() smartsplits.resize_down(1) end, { desc = 'resize to down' })
vim.keymap.set('n', '<A-k>', function() smartsplits.resize_up(1) end, { desc = 'resize to up' })
vim.keymap.set('n', '<A-l>', function() smartsplits.resize_right(1) end, { desc = 'resize to right' })

-- moving between splits
-- the letters are capital even with shift because of wezterm
vim.keymap.set('n', "<C-S-H>", smartsplits.move_cursor_left, { desc = 'move cursor left' })
vim.keymap.set('n', "<C-S-J>", smartsplits.move_cursor_down, { desc = 'move cursor down' })
vim.keymap.set('n', "<C-S-K>", smartsplits.move_cursor_up, { desc = 'move cursor up' })
vim.keymap.set('n', "<C-S-L>", smartsplits.move_cursor_right, { desc = 'move cursor right' })
