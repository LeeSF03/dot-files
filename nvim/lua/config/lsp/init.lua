local filepath = "config.lsp."
require(filepath .. "setup")

-- lsp servers
require(filepath .. "lua_lsp")
require(filepath .. "web_lsp")
require(filepath .. "docker_lsp")
