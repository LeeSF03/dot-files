local bufferline = require('bufferline')
local devicons = require('nvim-web-devicons')

bufferline.setup({
  highlights = {
    fill = {
      bg = '#181825',
    },
    background = {
      bg = '#232634',
    },
    tab = {
      fg = '#00ff00',
      bg = '#00ff00',
    },
    buffer_visible = {
      bg = '#232634',
    },
    close_button = {
      bg = '#232634',
    },
    close_button_visible = {
      bg = '#232634',
    },
    separator = {
      -- fg = '#11111b',
      fg = '#181825',
      bg = '#232634',
    },
    separator_visible = {
      fg = '#181825',
      bg = '#232634',
    },
    separator_selected = {
      fg = '#181825',
    },
  },
  options = {
    separator_style = "slant",
    -- indicator = {
    --   style = "none",
    -- },
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
