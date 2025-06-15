return {
  'mrjones2014/smart-splits.nvim',
  event = "VeryLazy",
  keys = {
    -- Resize splits
    { "<A-h>", function() require("smart-splits").resize_left(1) end,      desc = "Resize to left",    mode = { "n", "t" } },
    { "<A-j>", function() require("smart-splits").resize_down(1) end,      desc = "Resize to down",    mode = { "n", "t" } },
    { "<A-k>", function() require("smart-splits").resize_up(1) end,        desc = "Resize to up",      mode = { "n", "t" } },
    { "<A-l>", function() require("smart-splits").resize_right(1) end,     desc = "Resize to right",   mode = { "n", "t" } },

    -- Move between splits
    { "<C-h>", function() require("smart-splits").move_cursor_left() end,  desc = "Move cursor left",  mode = { "n", "t" } },
    { "<C-j>", function() require("smart-splits").move_cursor_down() end,  desc = "Move cursor down",  mode = { "n", "t" } },
    { "<C-k>", function() require("smart-splits").move_cursor_up() end,    desc = "Move cursor up",    mode = { "n", "t" } },
    { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Move cursor right", mode = { "n", "t" } },
  },
}
