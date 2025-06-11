---@brief
---
--- https://github.com/joe-re/sql-language-server
---
--- This LSP can be installed via  `npm`. Find further instructions on manual installation of the sql-language-server at [joe-re/sql-language-server](https://github.com/joe-re/sql-language-server).
---
---
--- There are two ways to use configuration files.
--- Set personal configuration file (~/.config/sql-language-server/.sqllsrc.json)
--- Set project configuration file on your project root (${YOUR_PROJECT}/.sqllsrc.json)
--- Use workspace/configuration according to LSP specification
---
--- Example of configuration:
--- {
---   "connections": [
---     {
---       "name": "sql-language-server",
---       "adapter": "mysql",
---       "host": "localhost",
---       "port": 3307,
---       "user": "username",
---       "password": "password",
---       "database": "mysql-development",
---       "projectPaths": ["/Users/joe-re/src/sql-language-server"], -- optional
---       "ssh": {
---         "user": "ubuntu",
---         "remoteHost": "ec2-xxx-xxx-xxx-xxx.ap-southeast-1.compute.amazonaws.com",
---         "dbHost": "127.0.0.1",
---         "port": 3306,
---         "identityFile": "~/.ssh/id_rsa",
---         "passphrase": "123456"
---       }
---     },
---     {
---       "name": "postgres-project",
---       "adapter": "postgres",
---       "host": "localhost",
---       "port": 5432,
---       "user": "postgres",
---       "password": "pg_pass",
---       "database": "pg_test",
---       "projectPaths": ["/Users/joe-re/src/postgres_project"] -- optional
---     },
---     {
---       "name": "sqlite3-project",
---       "adapter": "sqlite3",
---       "filename": "/Users/joe-re/src/sql-language-server/packages/server/test.sqlite3",
---       "projectPaths": ["/Users/joe-re/src/sqlite2_project"] -- optional
---     }
---   ]
--- }

vim.lsp.config("sqlls", {
  cmd = { 'sql-language-server', 'up', '--method', 'stdio' },
  filetypes = { 'sql', 'mysql' },
  root_markers = { '.sqllsrc.json' },
  settings = {},
})
