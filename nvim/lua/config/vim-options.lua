local acmd = vim.api.nvim_create_autocmd
local agrp = vim.api.nvim_create_augroup

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
vim.cmd([[
  autocmd FileType dashboard setlocal nofoldenable
]])
vim.cmd("packadd cfilter")
vim.cmd("set shortmess+=S")

local function set_filetype(pattern, filetype)
  acmd({ "BufRead", "BufNewFile" }, {
    pattern = pattern,
    command = "set filetype=" .. filetype,
  })
end

set_filetype({ "docker-compose.*.yml" }, "yaml.docker-compose")
set_filetype({ "docker-compose.*.yaml" }, "yaml.docker-compose")
set_filetype({ "docker-compose.yaml" }, "yaml.docker-compose")
set_filetype({ "docker-compose.yml" }, "yaml.docker-compose")
set_filetype({ "*.xaml" }, "xml")
set_filetype({ "*.xml" }, "xml")

-- Autocommand Groups
acmd({ "ModeChanged" }, {
    pattern = { "*:[vV\x16]*" },
  callback = function()
    vim.cmd("set noshowcmd")
  end
})
acmd({ "ModeChanged" }, {
  pattern = { "[vV\x16]*:*" },
  callback = function()
    vim.cmd("set showcmd")
  end
})

acmd({ "BufEnter" }, {
  callback = function(event)
    local title = "nvim"
    if event.file ~= "" then
      title = string.format("nvim • %s", vim.fs.basename(event.file))
    end

    vim.fn.system({ "wezterm", "cli", "set-tab-title", title })
  end,
})

acmd({ "VimLeave", "VimLeavePre" }, {
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

local del_qf_item = function()
  local items = vim.fn.getqflist()
  local line = vim.fn.line('.')
  table.remove(items, line)
  vim.fn.setqflist(items, "r")
  vim.api.nvim_win_set_cursor(0, { line, 0 })
end

local qf_grp = agrp("Quickfix Customs", { clear = true })

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
