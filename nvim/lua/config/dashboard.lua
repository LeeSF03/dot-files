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
      ██████                           ████████████ █████████████   ████ ██████           █████      ██                     
     ██████                           ████████████████   ████  ███████████             █████                             
     ████        ████████████████ ███████████ ████            █████████ ███████████████████ ███   ███████████   
    ████         ███     ███       ███████    ███████████     █████████  ███    █████████████ █████ ██████████████   
   ████        ███████████████████████████  ████            █████████ ██████████ █████████ █████ █████ ████ █████   
 ██████  ███ ███     ███    █████████████████          ███████████ ███    ███ █████████ █████ █████ ████ █████  
████████████████████████████████████████████████          ██████  █████████████████████ ████ █████ █████ ████ ██████ 
]]

local selected_logo = logo_narrow
-- if vim.o.columns > 137 then selected_logo = logo_wide end

local logo = string.rep("\n", 1) .. selected_logo .. "\n\n"

local opts = {
  theme = "doom",
  hide = {
    -- this is taken care of by lualine
    -- enabling this messes up the actual laststatus setting after loading a file
    statusline = false,
  },
  config = {
    header = vim.split(logo, "\n"),
    -- stylua: ignore
    center = {
      { action = 'Telescope find_files',                           desc = " Find File",       icon = " ", key = "f" },
      { action = ":ene",                                           desc = " New File",        icon = " ", key = "n" },
      { action = 'Telescope oldfiles',                             desc = " Recent Files",    icon = " ", key = "r" },
      { action = 'Telescope live_grep',                            desc = " Find Text",       icon = " ", key = "g" },
      { action = ":checkhealth",                                   desc = " Check Health",    icon = " ", key = "h" },
      { action = "Lazy",                                           desc = " Lazy",            icon = "󰒲 ", key = "l" },
      { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit",            icon = " ", key = "q" },
    },
    footer = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      return {
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

vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#B4BEFE" })
vim.api.nvim_set_hl(0, "DashboardDesc", { fg = "#CBA6F7" })
vim.api.nvim_set_hl(0, "DashboardIcon", { fg = "#CBA6F7" })
vim.api.nvim_set_hl(0, "DashboardKey", { fg = "#F5C2E7" })
vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#BAC2DE" })

dashboard.setup(opts)
