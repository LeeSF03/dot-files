local lualine = require("lualine")
local harpoon = require("harpoon")

local modify_harpooned_buffer_title = function(file_path, idx)
  local filename = vim.fn.fnamemodify(file_path, ':t')
  local idx_str = string.format('%d.', idx)
  local title = ' ' .. idx_str .. filename

  local bufnr = vim.fn.bufnr(file_path, false)
  local is_modified = bufnr ~= -1 and vim.bo[bufnr].modified or false

  if is_modified then
    title = string.format('%s*', title)
  end

  return title
end

local file_status = function()
  local current_file = vim.fn.expand('%:p')
  local filename = vim.fn.fnamemodify(current_file, ':t')
  local title = '# ' .. filename

  local bufnr = vim.fn.bufnr(current_file, false)
  local is_modified = bufnr ~= -1 and vim.bo[bufnr].modified or false

  for idx, file in ipairs(harpoon:list().items) do
    local file_path = vim.fn.fnamemodify(file.value, ':p')
    local harpooned_buffer_title = modify_harpooned_buffer_title(file_path, idx)

    if file_path == current_file then
      return harpooned_buffer_title
    end
  end

  if is_modified then
    return title .. '*'
  end

  return title
end

local harpooned_files_status = function()
  local current_file = vim.fn.expand('%:p')
  local pinned_files = {}
  local is_current_file_harpooned = false

  for idx, file in ipairs(harpoon:list().items) do
    local file_path = vim.fn.fnamemodify(file.value, ':p')
    local title = modify_harpooned_buffer_title(file_path, idx)

    if file_path == current_file then
      is_current_file_harpooned = true
      local with_surround = string.format('[%s]', title)
      table.insert(pinned_files, with_surround)
    else
      local shortened
      if (#title > 18) then
        shortened = string.format('%s...', string.sub(title, 1, 15))
      else
        shortened = title
      end
      table.insert(pinned_files, shortened)
    end
  end

  if not is_current_file_harpooned then
    local filename = vim.fn.fnamemodify(current_file, ':t')
    local with_symbol = string.format('# %s', filename)

    local bufnr = vim.fn.bufnr(current_file, false)
    local is_modified = bufnr ~= -1 and vim.bo[bufnr].modified or false

    if is_modified then
      with_symbol = string.format('%s*', with_symbol)
    end

    local with_surround = string.format('[%s]', with_symbol)

    table.insert(pinned_files, with_surround)
  end

  return table.concat(pinned_files, ' ')
end


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
    lualine_c = { harpooned_files_status, 'searchcount', 'selectioncount' },
    lualine_x = { 'copilot', 'fileformat', 'filetype' },
    lualine_y = { 'os.date("%I:%M%p")' },
    lualine_z = { 'progress', 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename', 'searchcount', 'selectioncount' },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
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
  winbar = {
    -- lualine_a = { harpooned_files_status },
  },
  inactive_winbar = {
    -- lualine_a = { { file_status, separator = { left = '', right = '' } } },
  },
  extensions = { 'oil', 'lazy' }
})
