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
vim.cmd([[
autocmd FileType dashboard setlocal nofoldenable
]])

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

acmd({"BufEnter"}, {
  callback = function(event)
    local title = "nvim"
    if event.file ~= "" then
      title = string.format("nvim: %s", vim.fs.basename(event.file))
    end

    vim.fn.system({"wezterm", "cli", "set-tab-title", title})
  end,
})
acmd({ "VimLeave"}, {
  callback = function()
    vim.fn.system({"wezterm", "cli", "set-tab-title", "pwsh.exe"})
  end,
})

local del_qf_item = function()
  local items = vim.fn.getqflist()
  local line = vim.fn.line('.')
  table.remove(items, line)
  vim.fn.setqflist(items, "r")
  vim.api.nvim_win_set_cursor(0, { line, 0 })
end

acmd('FileType', {
  group = custom_group,
  pattern = 'qf',
  callback = function()

    -- `dd` deletes an item from the list.
    vim.keymap.set('n', 'dd', del_qf_item, { buffer = true })
    vim.keymap.set('x', 'd', del_qf_item, { buffer = true })
  end,
  desc = 'Quickfix tweaks',
})
