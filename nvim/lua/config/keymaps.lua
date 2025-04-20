-- gitsigns
vim.keymap.set('n', '<leader>gp', '<CMD>Gitsigns preview_hunk<CR>', { desc = 'Git Preview Hunk' })

-- lazygit
vim.keymap.set('n', '<leader>gg', '<CMD>LazyGit<CR>', { desc = 'Open Lazygit' })

-- neoclip
vim.keymap.set('n', '<leader>fn', '<CMD>Telescope neoclip<CR>', { noremap = true, silent = true, desc = 'Open neoclip history' })

-- oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>-", "<CMD>Oil --float<CR>", { desc = "Open parent directory in floating" })

-- scroll remap
vim.keymap.set({"n", "i", "v" }, "<C-u>", "<C-u>zz", { desc = "Scroll up half page" })
vim.keymap.set({"n", "i", "v" }, "<C-d>", "<C-d>zz", { desc = "Scroll down half page" })

-- disable keymaps
vim.keymap.set("n", ";", "", { desc = "Disable ; keymap" })

-- marks remap
vim.keymap.set("n", "\'\'", "]\'", { desc = "Go to next mark" })
vim.keymap.set("n", ";;", "[\'", { desc = "Go to next mark" })

-- toggleterm
-- vim.keymap.set({ 'n', 't' }, '<C-t>t', function() vim.cmd(tostring(vim.v.count1) .. "ToggleTerm") end, { desc = 'Open terminal in floating' })
-- vim.keymap.set({ 'n', 't' }, '<C-t>v', function() vim.cmd(tostring(vim.v.count1) .. "ToggleTerm direction=vertical") end, { desc = 'Open terminal in vertical split' })
-- vim.keymap.set({ 'n', 't' }, '<C-t>s', function() vim.cmd(tostring(vim.v.count1) .. "ToggleTerm direction=horizontal") end, { desc = 'Open terminal in horizontal split' })
-- vim.keymap.set('t', '<C-t>n', '<C-\\><C-n>', { desc = 'Turn into normal mode' })
-- vim.keymap.set({ 'n', 't' }, '<C-t>a', '<cmd>ToggleTermToggleAll<CR>', { desc = 'Toggle all terminal' })
-- vim.keymap.set({ 'n', 't' }, '<leader>ft', '<cmd>TermSelect<CR>', { desc = 'Find terminal' })
-- vim.keymap.set({ 'n', 'i' }, '<C-t><C-t>', '<cmd>ToggleTerm<CR>', { desc = 'Open terminal in vertical split' })
-- vim.keymap.set('n', '<C-t><C-v>', '<cmd>ToggleTerm direction=vertical<CR>', { desc = 'Open terminal in vertical split' })
-- vim.keymap.set('n', '<C-t><C-s>', '<cmd>ToggleTerm direction=horizontal<CR>', { desc = 'Open terminal in horizontal split' })
