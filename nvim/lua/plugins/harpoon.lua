return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- "nvim-telescope/telescope.nvim",
	},
	-- event = "VeryLazy",
	config = function()
		require("config.harpoon").setup_autocmd()
	end,
  -- stylua: ignore
  keys = {
    { "M",          function() require("config.harpoon").toggle_mark_and_shift() end,                  desc = "Toggle Harpoon Mark" },
    { "<leader>mm", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon Quick Menu" },

    { "<leader>1",  function() require("config.harpoon").select_index(1) end },
    { "<leader>2",  function() require("config.harpoon").select_index(2) end },
    { "<leader>3",  function() require("config.harpoon").select_index(3) end },
    { "<leader>4",  function() require("config.harpoon").select_index(4) end },
    { "<leader>5",  function() require("config.harpoon").select_index(5) end },
    { "<leader>6",  function() require("config.harpoon").select_index(6) end },
    { "<leader>7",  function() require("config.harpoon").select_index(7) end },
    { "<leader>8",  function() require("config.harpoon").select_index(8) end },
    { "<leader>9",  function() require("config.harpoon").select_index(9) end },
    { "<leader>0",  function() require("config.harpoon").select_index(10) end },

    { "[m",         function() require("config.harpoon").select_previous_harpooned_file() end,         desc = "Previous Harpoon File" },
    { "]m",         function() require("config.harpoon").select_next_harpooned_file() end,             desc = "Next Harpoon File" },
  },
}
