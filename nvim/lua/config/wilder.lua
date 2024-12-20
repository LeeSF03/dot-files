local wilder = require('wilder')
wilder.setup({ modes = { ':', '/', '?' } })

wilder.set_option('renderer', wilder.popupmenu_renderer(
  wilder.popupmenu_border_theme({
    highlights = {
      border = wilder.make_hl('Border', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#89b4fa' } }),
      accent = wilder.make_hl('Accent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#ea76cb' } }),
      selected = wilder.make_hl('SelectedCommand', 'Pmenu',
        { { a = 1 }, { a = 1 }, { foreground = '#ea76cb', background = '#45475a' } }),
    },
    -- 'single', 'double', 'rounded' or 'solid'
    -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
    border = 'rounded',
    highlighter = wilder.basic_highlighter(),
    left = { ' ', wilder.popupmenu_devicons() },
    right = { ' ', wilder.popupmenu_scrollbar() },
  })
))
