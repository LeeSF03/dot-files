local colorizer = require('colorizer')

colorizer.setup({
  user_default_options = {
    RRGGBBAA = true,
    css = true,
    css_fn = true,
    hsl_fn = true,
    rgb_fn = true,
    mode = 'virtualtext',
    virtualtext_inline = true,
  },
})
