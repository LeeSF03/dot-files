local harpoon = require("harpoon")
local Path = require("plenary.path")

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


local function toggle_mark_and_shift()
  local list = harpoon:list()
  local current_path = vim.fn.expand("%:p")
  local original = list.items
  local new_list = {}

  -- Step 1: Copy all items into a new list
  for _, mark in ipairs(original) do
    table.insert(new_list, mark.value)
  end

  -- Step 2: Find and remove current file, shifting rest
  local removed = false
  for i, path in ipairs(new_list) do
    if Path:new(path):absolute() == current_path then
      table.remove(new_list, i)
      removed = true
      break
    end
  end

  -- Step 3: If not removed, then add it
  if not removed then
    table.insert(new_list, current_path)
  end

  -- Step 4: Clear list manually by removing all current marks
  for i = #original, 1, -1 do
    local mark = original[i]
    if mark then
      list:remove(mark)
    end
  end

  -- Step 5: Re-add in order
  for _, path in ipairs(new_list) do
    list:add({ value = path })
  end

  if removed then
    print("Removed and shifted Harpoon mark: " .. current_path)
  else
    print("Added to Harpoon: " .. current_path)
  end
end

local function select_next_harpooned_file()
  local list = harpoon:list()
  local current_path = vim.fn.expand("%:p")
  local marks = list.items

  for i, mark in ipairs(marks) do
    if Path:new(mark.value):absolute() == current_path then
      if (i == #list.items) then
        list:select(1)
      else
        list:select(i + 1)
      end
      return
    end
  end

  if (#list.items > 0) then
    list:select(1)
  end
end

local function select_previous_harpooned_file()
  local list = harpoon:list()
  local current_path = vim.fn.expand("%:p")
  local marks = list.items

  for i, mark in ipairs(marks) do
    if Path:new(mark.value):absolute() == current_path then
      if (i == 1) then
        list:select(#list.items)
      else
        list:select(i - 1)
      end
      return
    end
  end

  if (#list.items > 0) then
    list:select(#list.items)
  end
end

vim.keymap.set("n", "M", toggle_mark_and_shift, { desc = "Toggle Harpoon Mark" })
vim.keymap.set("n", "<leader>mm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end)
vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end)
vim.keymap.set("n", "<leader>7", function() harpoon:list():select(7) end)
vim.keymap.set("n", "<leader>8", function() harpoon:list():select(8) end)
vim.keymap.set("n", "<leader>9", function() harpoon:list():select(9) end)
vim.keymap.set("n", "<leader>0", function() harpoon:list():select(10) end)

-- Disable incase of other keymaps
vim.keymap.set("n", ",", "")
vim.keymap.set("n", ".", "")

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", ",,", select_previous_harpooned_file)
vim.keymap.set("n", "..", select_next_harpooned_file)
