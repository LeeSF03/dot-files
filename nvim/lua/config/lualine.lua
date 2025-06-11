local lualine = require("lualine")
local harpoon = require("harpoon")

local mode_colors = {
  ["n"] = "#89b4fa", -- Normal (Blue)
  ["i"] = "#a6e3a1", -- Insert (Green)
  ["v"] = "#cba6f7", -- Visual (Mauve)
  ["V"] = "#cba6f7", -- Visual Line (Mauve)
  [""] = "#cba6f7", -- Visual Block (Mauve) - ctrl-v
  ["c"] = "#fab387", -- Command (Peach)
  ["R"] = "#f38ba8", -- Replace (Red)
  ["t"] = "#a6e3a1", -- Terminal (Green)
}

local function get_mode_color()
  local mode = vim.api.nvim_get_mode().mode
  return mode_colors[mode] or "#89b4fa" -- fallback to default text color
end

local modify_harpooned_buffer_title = function(file_path, idx)
  local filename = vim.fn.fnamemodify(file_path, ':t')
  local idx_str = string.format('%d•', idx)
  local title = ' ' .. idx_str .. filename

  local bufnr = vim.fn.bufnr(file_path, false)
  local is_modified = bufnr ~= -1 and vim.bo[bufnr].modified or false

  if is_modified then
    title = string.format('*%s', title)
  end

  return title
end

local function is_index_has_file(index)
  local file = harpoon:list():get(index)
  if not file then
    return false
  end
  return true
end

local function harpooned_file_status(index)
  local current_file = vim.fn.expand('%:p')

  local file = harpoon:list():get(index)
  local file_path = vim.fn.fnamemodify(file.value, ':p')
  local title = modify_harpooned_buffer_title(file_path, index)

  if file_path == current_file then
    local with_surround = string.format('%s', title)
    return with_surround
  else
    local shortened
    if #title > 20 then
      shortened = string.format('%s...', string.sub(title, 1, 17))
    else
      shortened = title
    end
    return shortened
  end
end

local function harpoon_color(index)
  local current_file_path = vim.fn.expand('%:p')
  local file = harpoon:list():get(index)
  if not file then
    return nil
  end
  local harpooned_file_path = vim.fn.fnamemodify(file.value, ':p')
  return (harpooned_file_path == current_file_path) and { bg = get_mode_color(), fg = '#1e1e2e' } or
      { bg = '#1e1e2e', fg = '#cdd6f4' }
end

local function is_current_file_not_harpooned()
  local current_file = vim.fn.expand('%:p')

  for _, file in ipairs(harpoon:list().items) do
    local file_path = vim.fn.fnamemodify(file.value, ':p')

    if file_path == current_file then
      return false
    end
  end
  return true
end

local function unharpooned_file()
  local file_path = vim.fn.expand('%:p')
  local filename = vim.fn.fnamemodify(file_path, ':t')

  local bufnr = vim.fn.bufnr(file_path, false)
  local is_modified = bufnr ~= -1 and vim.bo[bufnr].modified or false

  if is_modified then
    filename = string.format('*%s', filename)
  end

  return filename
end

local lualine_c = {}
for i = 1, 10 do
  table.insert(lualine_c, {
    function()
      return harpooned_file_status(i)
    end,
    cond = function() return is_index_has_file(i) end,
    separator = { left = i == 1 and '' or '', right = '' },
    color = function(section)
      return harpoon_color(i)
    end,
  })
end
table.insert(lualine_c, {
  unharpooned_file,
  cond = is_current_file_not_harpooned,
  separator = { left = '', right = '' },
  color = function(section)
    local mode = vim.fn.mode()
    local color = mode_colors[mode] or "#cdd6f4"
    return { bg = color, fg = '#1e1e2e' }
  end,
})
table.insert(lualine_c, 'searchcount')
table.insert(lualine_c, 'selectioncount')

lualine.setup({
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = { 'dashboard', 'lazy' },
      winbar = { 'dashboard', 'lazy' },
    },
    ignore_focus = {},
    -- always_divide_middle = true,
    -- always_show_tabline = true,
    globalstatus = true,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = lualine_c,
    lualine_x = { 'copilot', 'fileformat', 'filetype' },
    lualine_y = { 'os.date("%I:%M%p")' },
    lualine_z = { 'progress', 'location' }
  },
  inactive_sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = lualine_c,
    lualine_x = { 'copilot', 'fileformat', 'filetype' },
    lualine_y = { 'os.date("%I:%M%p")' },
    lualine_z = { 'progress', 'location' }
  },
  tabline = {
    lualine_a = { {
      'tabs',
      mode = 2,
      tabs_color = {
        active = { fg = '#1e1e2e', bg = '#89b4fa' },
        inactive = { fg = '#89b4fa', bg = '#1e1e2e' }
      },
    } },
  },
  extensions = { 'oil', 'lazy' }
})
