-- Command settings
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("autocmd InsertEnter * :set norelativenumber")
vim.cmd("autocmd InsertLeave * :set relativenumber")
vim.cmd("set noshowmode")
-- vim.cmd("set fileformat=unix")
vim.cmd("set equalalways")
vim.cmd("set spell")
vim.cmd("set guicursor=n-v-c-i:block")
vim.cmd("packadd cfilter")
vim.cmd("set shortmess+=S")

-- Diagnostic settings
vim.diagnostic.config({ virtual_text = true })

-- Autocommands shortcut
local acmd = vim.api.nvim_create_autocmd
local agrp = vim.api.nvim_create_augroup

-- Function definitions
local function set_filetype(pattern, filetype)
  acmd({ "BufRead", "BufNewFile" }, {
    pattern = pattern,
    command = "set filetype=" .. filetype,
  })
end

local del_qf_item = function()
  local items = vim.fn.getqflist()
  local line = vim.fn.line('.')
  table.remove(items, line)
  vim.fn.setqflist(items, "r")
  vim.api.nvim_win_set_cursor(0, { line, 0 })
end

-- Function initialization
set_filetype({ "docker-compose.*.yml" }, "yaml.docker-compose")
set_filetype({ "docker-compose.*.yaml" }, "yaml.docker-compose")
set_filetype({ "docker-compose.yaml" }, "yaml.docker-compose")
set_filetype({ "docker-compose.yml" }, "yaml.docker-compose")
set_filetype({ "*.xaml" }, "xml")
set_filetype({ "*.xml" }, "xml")

-- Autocommand Groups
local wezterm_title_grp = agrp("WezTermTitle", { clear = true })
local qf_grp = agrp("Quickfix Customs", { clear = true })

acmd({ "BufEnter" }, {
  group = wezterm_title_grp,
  callback = function(event)
    local title = "nvim"
    if event.file ~= "" then
      title = string.format("nvim • %s", vim.fs.basename(event.file))
    end

    vim.fn.system({ "wezterm", "cli", "set-tab-title", title })
  end,
})
acmd({ "VimLeave", "VimLeavePre" }, {
  group = wezterm_title_grp,
  callback = function()
    vim.fn.system({ "wezterm", "cli", "set-tab-title", "pwsh.exe" })
  end,
})

acmd("VimEnter", {
  callback = function()
    -- To fix issue with lualine across windows
    vim.o.laststatus = 3
  end
})

acmd('FileType', {
  group = qf_grp,
  pattern = 'qf',
  callback = function()
    -- `dd` deletes an item from the list.
    vim.keymap.set('n', 'dd', del_qf_item, { buffer = true })
    vim.keymap.set('x', 'd', del_qf_item, { buffer = true })
  end,
  desc = 'Quickfix Delete Item',
})
