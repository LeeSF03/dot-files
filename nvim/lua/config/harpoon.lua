local harpoon = require("harpoon")
local Path = require("plenary.path")

harpoon:extend(require("harpoon.extensions").builtins.highlight_current_file())
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#f38ba8", bold = true })

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

function M.toggle_mark_and_shift(filepath)
	local list = harpoon:list()
	-- local current_path = vim.fn.expand("%:p")
	local current_path = filepath and vim.fn.fnamemodify(filepath, ":p") or vim.fn.expand("%:p")
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
	local items = harpoon:list().items
	if index < 1 or index > #items then
		print("No file is harpooned at index " .. index)
		return
	end
	print(vim.fn.fnamemodify(items[index].value, ":p"))
	harpoon:list():select(index)
	vim.cmd("UfoEnableFold")

	-- local current_file = vim.fn.expand("%:p")
	-- print(current_file)

	-- for _, file in ipairs(harpoon:list().items) do
	-- 	local file_path = vim.fn.fnamemodify(file.value, ":p")
	--
	-- 	if file_path == current_file then
	-- 		harpoon:list():select(index)
	-- 		-- vim.cmd("UfoEnableFold")
	-- 		return
	-- 	end
	-- end
end

function M.select_next_harpooned_file()
	local list = harpoon:list()
	local current_path = vim.fn.expand("%:p")
	local marks = list.items

	for i, mark in ipairs(marks) do
		if Path:new(mark.value):absolute() == current_path then
			if i == #list.items then
				M.select_index(1)
			else
				M.select_index(i + 1)
			end
			return
		end
	end

	-- if current file is not in the list, select the first one (oldest added)
	if #list.items > 0 then
		M.select_index(1)
	end
end

function M.select_previous_harpooned_file()
	local list = harpoon:list()
	local current_path = vim.fn.expand("%:p")
	local marks = list.items

	for i, mark in ipairs(marks) do
		if Path:new(mark.value):absolute() == current_path then
			if i == 1 then
				M.select_index(#list.items)
			else
				M.select_index(i - 1)
			end
			return
		end
	end

	-- if current file is not in the list, select the last one (most recently added)
	if #list.items > 0 then
		M.select_index(#list.items)
	end
end

---Removes non-existent files from the Harpoon list
local clean_nonexistent_marks = function()
	local list = harpoon:list()
	local original = list.items
	local new_list = {}

	-- Step 1: Copy only existing file paths into a new list
	for _, mark in ipairs(original) do
		local path = Path:new(mark.value)
		if path:exists() then
			table.insert(new_list, mark.value)
		end
	end

	-- Step 2: Clear all items manually
	for i = #original, 1, -1 do
		local mark = original[i]
		if mark then
			list:remove(mark)
		end
	end

	-- Step 3: Re-add only existing paths (shifting happens naturally)
	for _, path in ipairs(new_list) do
		list:add(list.config.create_list_item(list.config, path))
	end
end

---Replaces a marked file path with its new name if it was renamed
---@param old_path string
---@param new_path string
function M.rename_mark(old_path, new_path)
	local list = harpoon:list()
	local original = list.items
	local replaced = false

	for _, mark in ipairs(original) do
		if Path:new(mark.value):absolute() == Path:new(old_path):absolute() then
			-- Replace the old path with the new one
			list:remove(mark)
			list:add(list.config.create_list_item(list.config, Path:new(new_path):absolute()))
			replaced = true
			break
		end
	end

	if replaced then
		vim.notify(string.format("Harpoon: updated mark after rename → %s", new_path), vim.log.levels.INFO)
	end
end

---Creates an autocmd that checks and cleans invalid Harpoon entries
function M.setup_autocmd()
	local group = vim.api.nvim_create_augroup("HarpoonMaintain", { clear = true })

	-- Clean up non-existent files
	vim.api.nvim_create_autocmd({ "BufEnter", "BufDelete", "BufFilePost", "FocusGained", "VimResume" }, {
		group = group,
		callback = function()
			clean_nonexistent_marks()
		end,
		desc = "Clean up non-existent Harpoon marks",
	})
end

return M
