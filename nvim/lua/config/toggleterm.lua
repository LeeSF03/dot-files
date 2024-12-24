local toggleterm = require("toggleterm")

toggleterm.setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
	start_in_insert = true,
	direction = "float",
	shell = "pwsh.exe -nologo",
	float_opts = {
		border = "curved",
	}
})

vim.keymap.set('n', '<C-t>t', function() vim.cmd(tostring(vim.v.count1) .. "ToggleTerm") end, { desc = 'Open terminal in floating' })
vim.keymap.set('n', '<C-t>v', function() vim.cmd(tostring(vim.v.count1) .. "ToggleTerm direction=vertical") end, { desc = 'Open terminal in vertical split' })
vim.keymap.set('n', '<C-t>s', function() vim.cmd(tostring(vim.v.count1) .. "ToggleTerm direction=horizontal") end, { desc = 'Open terminal in horizontal split' })
vim.keymap.set('t', '<C-t>n', '<C-\\><C-n>', { desc = 'Turn into normal mode' })
vim.keymap.set('n', '<C-t>a', '<cmd>ToggleTermToggleAll<CR>', { desc = 'Toggle all terminal' })
vim.keymap.set('n', '<leader>ft', '<cmd>TermSelect<CR>', { desc = 'Find terminal' })
-- vim.keymap.set({ 'n', 'i' }, '<C-t><C-t>', '<cmd>ToggleTerm<CR>', { desc = 'Open terminal in vertical split' })
-- vim.keymap.set('n', '<C-t><C-v>', '<cmd>ToggleTerm direction=vertical<CR>', { desc = 'Open terminal in vertical split' })
-- vim.keymap.set('n', '<C-t><C-s>', '<cmd>ToggleTerm direction=horizontal<CR>', { desc = 'Open terminal in horizontal split' })
