local wilder = require('wilder')
wilder.setup({ modes = { ':', '/', '?' } })

wilder.set_option('renderer', wilder.popupmenu_renderer(
  wilder.popupmenu_border_theme({
    highlights = {
      default = wilder.make_hl('WilderDefault', 'Pmenu', { { a = 1 }, { a = 1 }, { background = "#181825" } }),
      border = wilder.make_hl('WilderBorder', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#89b4fa', background = "#181825" } }),
      accent = wilder.make_hl('WilderAccent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#ea76cb', background = "#181825" } }),
      selected = wilder.make_hl('WilderSelected', 'Pmenu',
        { { a = 1 }, { a = 1 }, { background = '#2b2b3c', foreground = '#ea76cb' } }),
      selected_accent = wilder.make_hl('WilderSelectedAccent', 'Pmenu',
        { { a = 1 }, { a = 1 }, { background = '#2b2b3c', foreground = '#ea76cb', underline = true } }),
    },
    -- 'single', 'double', 'rounded' or 'solid'
    -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
    border = 'rounded',
    highlighter = wilder.basic_highlighter(),
    left = { ' ', wilder.popupmenu_devicons() },
    right = { ' ', wilder.popupmenu_scrollbar() },
  })
))
