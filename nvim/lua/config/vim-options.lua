vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("autocmd InsertEnter * :set norelativenumber")
vim.cmd("autocmd InsertLeave * :set relativenumber")
vim.cmd("set noshowmode")
vim.cmd([[
call camelcasemotion#CreateMotionMappings('<leader>')
]])
vim.cmd("set fileformat=unix")
vim.cmd("set equalalways")

local function set_filetype(pattern, filetype)
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = pattern,
        command = "set filetype=" .. filetype,
    })
end

set_filetype({ "docker-compose.*.yml" }, "yaml.docker-compose")
set_filetype({ "docker-compose.*.yaml" }, "yaml.docker-compose")
set_filetype({ "docker-compose.yaml" }, "yaml.docker-compose")
set_filetype({ "docker-compose.yml" }, "yaml.docker-compose")

vim.api.nvim_create_autocmd({"BufEnter"}, {
  callback = function(event)
    local title = "nvim"
    if event.file ~= "" then
      title = string.format("nvim: %s", vim.fs.basename(event.file))
    end

    vim.fn.system({"wezterm", "cli", "set-tab-title", title})
  end,
})
