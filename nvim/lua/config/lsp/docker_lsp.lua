---@brief
---
--- https://github.com/rcjsuen/dockerfile-language-server-nodejs
---
--- `docker-langserver` can be installed via `npm`:
--- ```sh
--- npm install -g dockerfile-language-server-nodejs
--- ```
---
--- Additional configuration can be applied in the following way:
--- ```lua
--- vim.lsp.config('dockerls', {
---     settings = {
---         docker = {
--- 	    languageserver = {
--- 	        formatter = {
--- 		    ignoreMultilineInstructions = true,
--- 		},
--- 	    },
--- 	}
---     }
--- })
--- ```
vim.lsp.config("dockerls", {
	cmd = { "docker-langserver", "--stdio" },
	filetypes = { "dockerfile" },
	root_markers = { "Dockerfile" },
})

---@brief
---
--- https://github.com/microsoft/compose-language-service
--- This project contains a language service for Docker Compose.
---
--- `compose-language-service` can be installed via `npm`:
---
--- ```sh
--- npm install @microsoft/compose-language-service
--- ```
---
--- Note: If the docker-compose-langserver doesn't startup when entering a `docker-compose.yaml` file, make sure that the filetype is `yaml.docker-compose`. You can set with: `:set filetype=yaml.docker-compose`.
vim.lsp.config("docker_compose_language_service", {
	cmd = { "docker-compose-langserver", "--stdio" },
	filetypes = { "yaml.docker-compose" },
	root_markers = { "docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml" },
})
