local dashboard = require("dashboard")

-- local logo = [[
--
--
--
--
--
--
--
-- ██╗     ███████╗███████╗ ██████╗███████╗
-- ██║     ██╔════╝██╔════╝██╔════╝██╔════╝
-- ██║     █████╗  █████╗  ╚█████╗ █████╗
-- ██║     ██╔══╝  ██╔══╝   ╚═══██╗██╔══╝
-- ███████╗███████╗███████╗██████╔╝██║
-- ╚══════╝╚══════╝╚══════╝╚═════╝ ╚═╝
-- ]]

local logo_narrow = [[
                                                                          
        ██████                           ████████████ ████████████  
       ██████                           ████████████████  ████  
       ████        ████████████████ ███████████ ████           
      ████         ███     ███       ███████    ████████████    
     ████        ███████████████████████████  ████             
   ██████  ███ ███     ███    █████████████████             
  ████████████████████████████████████████████████              
                                                                          

                                                                        
         ████ ██████           █████      ██                      
        ███████████             █████                              
        █████████ ███████████████████ ███   ███████████    
       █████████  ███    █████████████ █████ ██████████████    
      █████████ ██████████ █████████ █████ █████ ████ █████    
    ███████████ ███    ███ █████████ █████ █████ ████ █████   
   ██████  █████████████████████ ████ █████ █████ ████ ██████  
]]

local logo_wide = [[






                                                                                                                                      
      ██████                           ████████████ ████████████   ████ ██████           █████      ██                    
     ██████                           ████████████████  ████  ███████████             █████                            
     ████        ████████████████ ███████████ ████           █████████ ███████████████████ ███   ███████████  
    ████         ███     ███       ███████    ████████████   █████████  ███    █████████████ █████ ██████████████  
   ████        ███████████████████████████  ████           █████████ ██████████ █████████ █████ █████ ████ █████  
 ██████  ███ ███     ███    █████████████████         ███████████ ███    ███ █████████ █████ █████ ████ █████ 
████████████████████████████████████████████████         ██████  █████████████████████ ████ █████ █████ ████ ██████
]]

local selected_logo = logo_narrow
-- if vim.o.columns > 137 then selected_logo = logo_wide end

local logo = string.rep("\n", 1) .. selected_logo .. "\n\n"

local opts = {
  theme = "doom",
  hide = {
    -- this is taken care of by lualine
    -- enabling this messes up the actual laststatus setting after loading a file
    statusline = true,
    winbar = true,
  },
  config = {
    header = vim.split(logo, "\n"),
    -- stylua: ignore
    center = {
      { action = 'Telescope find_files', desc = " Find File", icon = " ", key = "f" },
      { action = ":ene", desc = " New File", icon = " ", key = "n" },
      -- { action = 'TelescopeHarpoon', desc = " Marked Files", icon = " ", key = "m" },
      { action = 'Telescope live_grep', desc = " Find Text", icon = " ", key = "g" },
      { action = ":e C:\\Users\\shuen\\.config\\nvim\\lua\\config\\lsp\\init.lua", desc = " Language Server File", icon = " ", key = "s" },
      { action = "checkhealth", desc = " Check Health", icon = " ", key = "h" },
      { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
      { action = function() vim.api.nvim_input("<CMD>qa<CR>") end, desc = " Quit", icon = " ", key = "q" },
    },
    footer = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      return {
        "",
        "󱐋 Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
      }
    end,
  },
}

for _, button in ipairs(opts.config.center) do
  button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
  button.key_format = "  %s"
end

-- open dashboard after closing lazy
if vim.o.filetype == "lazy" then
  vim.api.nvim_create_autocmd("WinClosed", {
    pattern = tostring(vim.api.nvim_get_current_win()),
    once = true,
    callback = function()
      vim.schedule(function()
        vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
      end)
    end,
  })
end

-- Attempt to redraw the dashboard on resize
-- vim.api.nvim_create_autocmd("VimResized", {
--   callback = function()
--     local new_logo = logo_narrow
--     if vim.o.columns > 137 then new_logo = logo_wide end
--
--     local formatted_logo = string.rep("\n", 1) .. new_logo .. "\n\n"
--     opts.config.header = vim.split(formatted_logo, "\n")
--
--     dashboard.setup(opts)
--     print("there should be a new logo")
--     vim.cmd("Dashboard")
--   end,
-- })

vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#b4befe" })
vim.api.nvim_set_hl(0, "DashboardDesc", { fg = "#cba6f7" })
vim.api.nvim_set_hl(0, "DashboardIcon", { fg = "#f5c2e7" })
vim.api.nvim_set_hl(0, "DashboardKey", { fg = "#f5c2e7" })
vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#f9e2af" })

dashboard.setup(opts)
