local bufferline = require('bufferline')
local devicons = require('nvim-web-devicons')

bufferline.setup({
  options = {
    get_element_icon = function(element)
      -- element consists of {filetype: string, path: string, extension: string, directory: string}
      -- This can be used to change how bufferline fetches the icon
      -- for an element e.g. a buffer or a tab.
      -- e.g.
      if (string.find(element.path, "docker")) then
        local icon, hl = devicons.get_icon_by_filetype("dockerfile", { default = false })
        return icon, hl
      end
      local icon, hl = devicons.get_icon_by_filetype(element.filetype, { default = false })
      return icon, hl
    end,
  }
})

vim.keymap.set('n', '<leader>]', '<cmd>BufferLineCycleNext<CR>', { desc = 'Switch to next buffer' })
vim.keymap.set('n', '<leader>[', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Switch to previous buffer' })
vim.keymap.set('n', '<leader>}', '<cmd>BufferLineMoveNext<CR>', { desc = 'Swap with next buffer' })
vim.keymap.set('n', '<leader>{', '<cmd>BufferLineMovePrev<CR>', { desc = 'Swap with previous buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Delete current buffer' })
vim.keymap.set('n', '<leader>bn', '<cmd>:enew<CR>', { desc = 'Create new unname buffer' })
