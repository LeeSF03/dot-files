local lspconfig = require("lspconfig")
local blink = require("blink.cmp")
local capabilities = blink.get_lsp_capabilities()

-- python language server setup
lspconfig.basedpyright.setup({
  capabilities = capabilities,
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git", ".venv" }
  -- settings = {
  --   basedpyright = {
  --     venvPath = ".", -- path to folder *containing* the venv
  --     venv = ".venv", -- name of the venv folder
  --   },
  -- },
})
