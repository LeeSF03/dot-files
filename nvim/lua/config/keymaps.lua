-- gitsigns
vim.keymap.set('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<CR>', { desc = 'Git Preview Hunk' })

-- bufferline
vim.keymap.set('n', '<leader>]', '<cmd>BufferLineCycleNext<CR>', { desc = 'Switch to next buffer' })
vim.keymap.set('n', '<leader>[', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Switch to previous buffer' })
vim.keymap.set('n', '<leader>}', '<cmd>BufferLineMoveNext<CR>', { desc = 'Swap with next buffer' })
vim.keymap.set('n', '<leader>{', '<cmd>BufferLineMovePrev<CR>', { desc = 'Swap with previous buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Delete current buffer' })
vim.keymap.set('n', '<leader>bn', '<cmd>:enew<CR>', { desc = 'Create new unname buffer' })

-- lazygit
vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<CR>', { desc = 'Open Lazygit' })

-- neoclip
vim.keymap.set('n', '<leader>fn', '<cmd>Telescope neoclip<CR>', { noremap = true, silent = true, desc = 'Open neoclip history' })

-- oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>-", "<CMD>Oil --float<CR>", { desc = "Open parent directory in floating" })

-- toggleterm
vim.keymap.set({ 'n', 't' }, '<C-t>t', function() vim.cmd(tostring(vim.v.count1) .. "ToggleTerm") end, { desc = 'Open terminal in floating' })
vim.keymap.set({ 'n', 't' }, '<C-t>v', function() vim.cmd(tostring(vim.v.count1) .. "ToggleTerm direction=vertical") end, { desc = 'Open terminal in vertical split' })
vim.keymap.set({ 'n', 't' }, '<C-t>s', function() vim.cmd(tostring(vim.v.count1) .. "ToggleTerm direction=horizontal") end, { desc = 'Open terminal in horizontal split' })
vim.keymap.set('t', '<C-t>n', '<C-\\><C-n>', { desc = 'Turn into normal mode' })
vim.keymap.set({ 'n', 't' }, '<C-t>a', '<cmd>ToggleTermToggleAll<CR>', { desc = 'Toggle all terminal' })
vim.keymap.set({ 'n', 't' }, '<leader>ft', '<cmd>TermSelect<CR>', { desc = 'Find terminal' })
-- vim.keymap.set({ 'n', 'i' }, '<C-t><C-t>', '<cmd>ToggleTerm<CR>', { desc = 'Open terminal in vertical split' })
-- vim.keymap.set('n', '<C-t><C-v>', '<cmd>ToggleTerm direction=vertical<CR>', { desc = 'Open terminal in vertical split' })
-- vim.keymap.set('n', '<C-t><C-s>', '<cmd>ToggleTerm direction=horizontal<CR>', { desc = 'Open terminal in horizontal split' })
