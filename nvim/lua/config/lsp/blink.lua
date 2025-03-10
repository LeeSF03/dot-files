local blink = require("blink.cmp")

blink.setup({
  keymap = {
    ['<C-s>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide' },
    ['<C-y>'] = { 'select_and_accept' },

    -- ['<C-k>'] = { 'select_prev', 'fallback' },
    -- ['<C-j>'] = { 'select_next', 'fallback' },

    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
  },
  completion = {
    menu = {
      border = 'rounded',
      draw = {
        align_to = 'cursor',
      },
    },
    documentation = {
      window = {
        border = 'rounded',
      },
      auto_show = true,
      auto_show_delay_ms = 500,
    },
  },
  -- experimental signature help support
  signature = {
    enabled = true,
    window = {
      border = 'rounded'
    }
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer", "copilot", "markdown" },
    providers = {
      copilot = {
        name = "copilot",
        module = "blink-cmp-copilot",
        score_offset = 100,
        async = true,
        transform_items = function(_, items)
          local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
          local kind_idx = #CompletionItemKind + 1
          CompletionItemKind[kind_idx] = "Copilot"
          for _, item in ipairs(items) do
            item.kind = kind_idx
          end
          return items
        end,
      },
      markdown = {
        name = 'RenderMarkdown',
        module = 'render-markdown.integ.blink',
        fallbacks = { 'lsp' },
      }
    },
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono',
    kind_icons = {
      Copilot = "",
      Text = '󰉿',
      Method = '󰊕',
      Function = '󰊕',
      Constructor = '󰒓',

      Field = '󰜢',
      Variable = '󰆦',
      Property = '󰖷',

      Class = '󱡠',
      Interface = '󱡠',
      Struct = '󱡠',
      Module = '󰅩',

      Unit = '󰪚',
      Value = '󰦨',
      Enum = '󰦨',
      EnumMember = '󰦨',

      Keyword = '󰻾',
      Constant = '󰏿',

      Snippet = '󱄽',
      Color = '󰏘',
      File = '󰈔',
      Reference = '󰬲',
      Folder = '󰉋',
      Event = '󱐋',
      Operator = '󰪚',
      TypeParameter = '󰬛',
    },
  },
})

-- Set autocomplete highlight
vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "#1e1e2e", })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#89b4fa", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = "#ea76cb" })
vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = "#1e1e2e", })
vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { fg = "#89b4fa", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#89b4fa", bg = "#1e1e2e" }) -- not working
