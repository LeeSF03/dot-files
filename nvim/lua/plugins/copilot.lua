return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = {
      "InsertEnter",
    },
    config = function()
      require("config.copilot")
    end,
  }
}
