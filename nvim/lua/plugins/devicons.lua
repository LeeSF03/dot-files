return {
	"nvim-tree/nvim-web-devicons",
	opts = {
		override = {},
    -- stylua: ignore start
		override_by_filename = {
			[".env.production"] = { icon = "", color = "#FAF743", cterm_color = "227", name = "Env" },
			[".env.prod"] = { icon = "", color = "#FAF743", cterm_color = "227", name = "Env" },
			[".env.dev"] = { icon = "", color = "#FAF743", cterm_color = "227", name = "Env" },
			[".env.development"] = { icon = "", color = "#FAF743", cterm_color = "227", name = "Env" },
			[".env.local"] = { icon = "", color = "#FAF743", cterm_color = "227", name = "Env" },
			[".env.production.local"] = { icon = "", color = "#FAF743", cterm_color = "227", name = "Env" },
			[".env.prod.local"] = { icon = "", color = "#FAF743", cterm_color = "227", name = "Env" },
			[".env.dev.local"] = { icon = "", color = "#FAF743", cterm_color = "227", name = "Env" },
			[".env.development.local"] = { icon = "", color = "#FAF743", cterm_color = "227", name = "Env" },

			["docker-compose.prod.yaml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },
			["docker-compose.prodduction.yaml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },
			["docker-compose.development.yaml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },
			["docker-compose.dev.yaml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },
			["docker-compose.prod.yml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },
			["docker-compose.production.yml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },
			["docker-compose.dev.yml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },
			["docker-compose.development.yml"] = { icon = "󰡨", color = "#458EE6", cterm_color = "68", name = "Dockerfile", },
		},
		-- stylua: ignore end
	},
	event = "VeryLazy",
}
