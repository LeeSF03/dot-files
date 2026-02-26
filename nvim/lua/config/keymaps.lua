-- stylua: ignore start
-- scroll remap
vim.keymap.set({"n", "i", "v" }, "<C-u>", "<C-u>zz", { desc = "Scroll up half page" })
vim.keymap.set({"n", "i", "v" }, "<C-d>", "<C-d>zz", { desc = "Scroll down half page" })

-- esc remap to disable highlight
vim.keymap.set({ "n" }, "<Esc>", "<Esc> <CMD>noh<CR>", { desc = "Disable highlight" })

-- disable keymaps
vim.keymap.set("n", ";", "", { desc = "Disable ; keymap" })

-- marks remap
vim.keymap.set("n", "\'\'", "]\'", { desc = "Go to next mark" })
vim.keymap.set("n", ";;", "[\'",   { desc = "Go to next mark" })
-- stylua: ignore end
