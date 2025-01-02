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
