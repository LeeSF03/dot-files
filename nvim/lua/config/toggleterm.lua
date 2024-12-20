local toggleterm = require("toggleterm")

toggleterm.setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
	open_mapping = [[<leader>tt]],
	start_in_insert = true,
	direction = "float",
	shell = "pwsh.exe -nologo",
	float_opts = {
		border = "curved",
    title_pos = "center",
	}
})

vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical<CR>', { desc = 'Open terminal in vertical split' })
vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<CR>', { desc = 'Open terminal in horizontal split' })
