return {
	"nvim-tree/nvim-web-devicons",
	-- This is to prevent this plugin to load on startup
	-- It will load when other plugins that depend on it are loaded, such as telescope and dashboard
	event = "InsertEnter",
	opts = {
    -- stylua: ignore start
		override_by_filename = {
			[".env.prod"] = { icon = "", color = "#FAF743", cterm_color = "227", name = "Env" },
			[".env.production"] = { icon = "", color = "#FAF743", cterm_color = "227", name = "Env" },
			[".env.dev"] = { icon = "", color = "#FAF743", cterm_color = "227", name = "Env" },
			[".env.development"] = { icon = "", color = "#FAF743", cterm_color = "227", name = "Env" },

			[".env.local"] = { icon = "", color = "#FAF743", cterm_color = "227", name = "Env" },
			[".env.prod.local"] = { icon = "", color = "#FAF743", cterm_color = "227", name = "Env" },
			[".env.production.local"] = { icon = "", color = "#FAF743", cterm_color = "227", name = "Env" },
			[".env.dev.local"] = { icon = "", color = "#FAF743", cterm_color = "227", name = "Env" },
			[".env.development.local"] = { icon = "", color = "#FAF743", cterm_color = "227", name = "Env" },

			["docker-compose.prod.yaml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },
			["docker-compose.prodduction.yaml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },
			["docker-compose.dev.yaml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },
			["docker-compose.development.yaml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },
			["docker-compose.prod.yml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },
			["docker-compose.production.yml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },
			["docker-compose.dev.yml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },
			["docker-compose.development.yml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },

			["compose.prod.yaml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },
			["compose.prodduction.yaml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },
			["compose.dev.yaml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },
			["compose.development.yaml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },
			["compose.prod.yml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },
			["compose.production.yml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },
			["compose.dev.yml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },
			["compose.development.yml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },

      [".ignore"] = { icon = "", color = "#F54D27", cterm_color = "196", name = "GitIgnore"},
      [".fdignore"] = { icon = "", color = "#F54D27", cterm_color = "196", name = "GitIgnore"},
      [".rgignore"] = { icon = "", color = "#F54D27", cterm_color = "196", name = "GitIgnore"},
		},
		-- stylua: ignore end
	},
}
