local harpoon = require("harpoon")
local Path = require("plenary.path")
local conf = require("telescope.config").values

harpoon:setup()

local M = {}

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


function M.toggle_mark_and_shift()
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
    list:add(list.config.create_list_item(list.config, path))
  end
end

function M.select_index(index)
  local current_file = vim.fn.expand('%:p')
  print(current_file)

  for _, file in ipairs(harpoon:list().items) do
    local file_path = vim.fn.fnamemodify(file.value, ':p')

    if file_path == current_file then
      harpoon:list():select(index)
      vim.cmd("UfoEnableFold")
      return
    end
  end

  local bufnr = vim.fn.bufnr(current_file, false)
  local is_modified = bufnr ~= -1 and vim.bo[bufnr].modified or false

  if is_modified then
    print("Cannot switch file if current file is modified and not harpooned.")
  else
    harpoon:list():select(index)
    vim.cmd("UfoEnableFold")
  end
end

function M.select_next_harpooned_file()
  local list = harpoon:list()
  local current_path = vim.fn.expand("%:p")
  local marks = list.items

  for i, mark in ipairs(marks) do
    if Path:new(mark.value):absolute() == current_path then
      if (i == #list.items) then
        list:select(1)
        vim.cmd("UfoEnableFold")
      else
        list:select(i + 1)
        vim.cmd("UfoEnableFold")
      end
      return
    end
  end

  if (#list.items > 0) then
    list:select(1)
    vim.cmd("UfoEnableFold")
  end
end

function M.select_previous_harpooned_file()
  local list = harpoon:list()
  local current_path = vim.fn.expand("%:p")
  local marks = list.items

  for i, mark in ipairs(marks) do
    if Path:new(mark.value):absolute() == current_path then
      if (i == 1) then
        list:select(#list.items)
        vim.cmd("UfoEnableFold")
      else
        list:select(i - 1)
        vim.cmd("UfoEnableFold")
      end
      return
    end
  end

  if (#list.items > 0) then
    list:select(#list.items)
    vim.cmd("UfoEnableFold")
  end
end

return M
