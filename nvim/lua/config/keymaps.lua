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

-- esc remap to disable highlight
vim.keymap.set({ "n" }, "<Esc>", "<Esc> <CMD>noh<CR>", { desc = "Disable highlight" })

-- disable keymaps
vim.keymap.set("n", ";", "", { desc = "Disable ; keymap" })

-- marks remap
vim.keymap.set("n", "\'\'", "]\'", { desc = "Go to next mark" })
vim.keymap.set("n", ";;", "[\'", { desc = "Go to next mark" })

--tab navigation
vim.keymap.set("n", "<leader>]", "<CMD>tabn<CR>", { desc = "Go to next tab" })
vim.keymap.set("n", "<leader>[", "<CMD>tabp<CR>", { desc = "Go to previous tab" })
