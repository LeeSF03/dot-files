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
-- vim.cmd("set fileformats=unix")
vim.cmd("set equalalways")
vim.cmd("set spell")
vim.cmd("set spelllang=en_us")
vim.cmd("set guicursor=n-v-c-i:block")
vim.cmd("packadd cfilter")
vim.cmd("set shortmess+=S")
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.g.editorconfig = true
vim.g.coq_settings = { ["autostart"] = "shut up" }

-- Diagnostic settings
vim.diagnostic.config({ virtual_text = true })
vim.api.nvim_set_hl(0, "Visual", { bg = "#585b70" })

-- Autocommands shortcut
local acmd = vim.api.nvim_create_autocmd
local agrp = vim.api.nvim_create_augroup

local del_qf_item = function()
	local items = vim.fn.getqflist()
	local line = vim.fn.line(".")
	table.remove(items, line)
	vim.fn.setqflist(items, "r")
	vim.api.nvim_win_set_cursor(0, { line, 0 })
end

vim.filetype.add({
	extension = {
		env = "sh",
	},
	filename = {
		[".env"] = "sh",
		["docker-compose.yml"] = "yaml.docker-compose",
		["docker-compose.yaml"] = "yaml.docker-compose",
		["compose.yml"] = "yaml.docker-compose",
		["compose.yaml"] = "yaml.docker-compose",
	},
	pattern = {
		["%.env%.[%w_.-]+"] = "sh",
		["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
		["compose.*%.ya?ml"] = "yaml.docker-compose",
		[".*%.xml"] = "xml",
	},
})

-- Autocommand Groups
acmd("VimEnter", {
	callback = function()
		-- To fix issue with lualine across windows
		vim.o.laststatus = 3
	end,
})

acmd("FileType", {
	group = agrp("Quickfix Customs", { clear = true }),
	pattern = "qf",
	callback = function()
		-- `dd` deletes an item from the list.
		vim.keymap.set("n", "dd", del_qf_item, { buffer = true })
		vim.keymap.set("x", "d", del_qf_item, { buffer = true })
	end,
	desc = "Quickfix Delete Item",
})

local deferred_load_timer = vim.uv.new_timer()
acmd({ "CursorMoved", "InsertCharPre", "TextChanged", "CmdlineChanged" }, {
	callback = function()
		deferred_load_timer:stop()
		deferred_load_timer:start(
			800,
			0,
			vim.schedule_wrap(function()
				vim.api.nvim_exec_autocmds("User", { pattern = "DeferredLoad" })
			end)
		)
	end,
})

-- Vim.notfiy
local notify_timer = vim.uv.new_timer()
local vim_notify = vim.notify

vim.notify = function(msg, level, opts)
	notify_timer:stop()

	vim_notify(msg, level, opts)
	notify_timer:start(
		5000,
		0,
		vim.schedule_wrap(function()
			vim.cmd("echo ''")
		end)
	)
end
