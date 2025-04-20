local harpoon = require("harpoon")

harpoon:setup()

harpoon:extend({
  UI_CREATE = function(cx)
    vim.keymap.set("n", "<C-v>", function()
      harpoon.ui:select_menu_item({ vsplit = true })
    end, { buffer = cx.bufnr })

    vim.keymap.set("n", "<C-s>", function()
      harpoon.ui:select_menu_item({ split = true })
    end, { buffer = cx.bufnr })
  end,
})

vim.keymap.set("n", "<leader>M", function() harpoon:list():add() end, { desc = "Toggle Harpoon Mark" })
vim.keymap.set("n", "<leader>mm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "4", function() harpoon:list():select(4) end)
vim.keymap.set("n", "5", function() harpoon:list():select(5) end)
vim.keymap.set("n", "6", function() harpoon:list():select(6) end)
vim.keymap.set("n", "7", function() harpoon:list():select(7) end)
vim.keymap.set("n", "8", function() harpoon:list():select(8) end)
vim.keymap.set("n", "9", function() harpoon:list():select(9) end)
vim.keymap.set("n", "0", function() harpoon:list():select(0) end)

-- Disable incase of other keymaps
vim.keymap.set("n", ",", "")
vim.keymap.set("n", ".", "")

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", ",,", function() harpoon:list():prev() end)
vim.keymap.set("n", "..", function() harpoon:list():next() end)
