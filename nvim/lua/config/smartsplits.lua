local smartsplits = require('smart-splits')

smartsplits.setup()

-- resize splits
vim.keymap.set('n', '<A-h>', function() smartsplits.resize_left(1) end)
vim.keymap.set('n', '<A-j>', function() smartsplits.resize_down(1) end)
vim.keymap.set('n', '<A-k>', function() smartsplits.resize_up(1) end)
vim.keymap.set('n', '<A-l>', function() smartsplits.resize_right(1) end)
-- moving between splits
vim.keymap.set('n', '<C-h>', smartsplits.move_cursor_left)
vim.keymap.set('n', '<C-j>', smartsplits.move_cursor_down)
vim.keymap.set('n', '<C-k>', smartsplits.move_cursor_up)
vim.keymap.set('n', '<C-l>', smartsplits.move_cursor_right)
