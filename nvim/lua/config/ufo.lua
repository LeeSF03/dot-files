local ufo = require('ufo')
local statuscol = require('statuscol')
local statuscol_builtin = require('statuscol.builtin')

vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = 'Open all folds' })
vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = 'Close all folds' })

ufo.setup({
  provider_selector = function(bufnr, filetype, buftype)
    if filetype == 'dashboard' then
      return ''
    end
    return { 'treesitter', 'indent' }
  end,
})

statuscol.setup({
  relculright = true,
  segments = {
    { text = { statuscol_builtin.foldfunc },      click = "v:lua.ScFa" },
    { text = { "%s" },                            click = "v:lua.ScSa" },
    { text = { statuscol_builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
  },
})
