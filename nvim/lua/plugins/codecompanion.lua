local prompts = require("config.codecompanion-prompt")

return {
  "olimorris/codecompanion.nvim",
  opts = {},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "zbirenbaum/copilot.lua",
    "ravitemer/codecompanion-history.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "markdown", "codecompanion" }
    },
    {
      "HakonHarnes/img-clip.nvim",
      opts = {
        filetypes = {
          codecompanion = {
            prompt_for_file_name = false,
            template = "[Image]($FILE_PATH)",
            use_absolute_path = true,
          },
        },
      },
    },
  },
  cmd = {
    "CodeCompanionChat",
    "CodeCompanionInline",
    "CodeCompanionCmd",
  },
  init = function()
    vim.keymap.set({ "n" }, "<leader>ai", "<CMD>CodeCompanionChat Toggle<CR>", { desc = "Toggle CodeCompanionChat" })
  end,
  config = function()
    local spinner = require("config.codecompanion-spinner")
    spinner:init()

    require("codecompanion").setup({
      display = {
        chat = {
          window = {
            position = "right",
            width = 0.35,
          },
        },
      },
      strategies = {
        chat = {
          -- adapter = "gemini-2.5-pro",
          -- adapter = "anthropic",
          adapter = "copilot",
          send = {
            callback = function(chat)
              vim.cmd("stopinsert")
              chat:submit()
            end,
            index = 1,
            description = "Send",
          },
          roles = {
            ---The header name for the LLM's messages
            ---@type string|fun(adapter: CodeCompanion.Adapter): string
            llm = function(adapter)
              return "CodeCompanion [" .. adapter.formatted_name .. ": " .. adapter.model.name .. "]"
            end,

            ---The header name for your messages
            ---@type string
            user = "Me",
          },
          keymaps = {
            options = {
              modes = {
                n = "?",
              },
              callback = "keymaps.options",
              description = "Options",
              hide = true,
            },
            completion = {
              modes = {
                i = "<C-y>",
              },
              index = 1,
              callback = "keymaps.completion",
              description = "Completion Menu",
            },
            send = {
              modes = {
                n = { "<CR>", "<C-s>" },
                i = "<C-s>",
              },
              index = 2,
              callback = "keymaps.send",
              description = "Send",
            },
            regenerate = {
              modes = {
                n = "<leader>ar",
              },
              index = 3,
              callback = "keymaps.regenerate",
              description = "Regenerate the last response",
            },
            close = {
              modes = {
                n = "<C-c>",
                i = "<C-c>",
              },
              index = 4,
              callback = "keymaps.close",
              description = "Close Chat",
            },
            stop = {
              modes = {
                n = "q",
              },
              index = 5,
              callback = "keymaps.stop",
              description = "Stop Request",
            },
            clear = {
              modes = {
                n = "<leader>ax",
              },
              index = 6,
              callback = "keymaps.clear",
              description = "Clear Chat",
            },
            codeblock = {
              modes = {
                n = "<leader>ac",
              },
              index = 7,
              callback = "keymaps.codeblock",
              description = "Insert Codeblock",
            },
            yank_code = {
              modes = {
                n = "<leader>ay",
              },
              index = 8,
              callback = "keymaps.yank_code",
              description = "Yank Code",
            },
            pin = {
              modes = {
                n = "<leader>ap",
              },
              index = 9,
              callback = "keymaps.pin_reference",
              description = "Pin Reference",
            },
            -- watch = {
            --   modes = {
            --     n = "aw",
            --   },
            --   index = 10,
            --   callback = "keymaps.toggle_watch",
            --   description = "Watch Buffer",
            -- },
            next_chat = {
              modes = {
                n = "}",
              },
              index = 11,
              callback = "keymaps.next_chat",
              description = "Next Chat",
            },
            previous_chat = {
              modes = {
                n = "{",
              },
              index = 12,
              callback = "keymaps.previous_chat",
              description = "Previous Chat",
            },
            next_header = {
              modes = {
                n = "]]",
              },
              index = 13,
              callback = "keymaps.next_header",
              description = "Next Header",
            },
            previous_header = {
              modes = {
                n = "[[",
              },
              index = 14,
              callback = "keymaps.previous_header",
              description = "Previous Header",
            },
            change_adapter = {
              modes = {
                n = "<leader>aa",
              },
              index = 15,
              callback = "keymaps.change_adapter",
              description = "Change adapter",
            },
            fold_code = {
              modes = {
                n = "<leader>af",
              },
              index = 15,
              callback = "keymaps.fold_code",
              description = "Fold code",
            },
            debug = {
              modes = {
                n = "<leader>ad",
              },
              index = 16,
              callback = "keymaps.debug",
              description = "View debug info",
            },
            system_prompt = {
              modes = {
                n = "<leader>as",
              },
              index = 17,
              callback = "keymaps.toggle_system_prompt",
              description = "Toggle the system prompt",
            },
            -- auto_tool_mode = {
            --   modes = {
            --     n = "ata",
            --   },
            --   index = 18,
            --   callback = "keymaps.auto_tool_mode",
            --   description = "Toggle automatic tool mode",
            -- },
            -- goto_file_under_cursor = {
            --   modes = { n = "<leader>ado" },
            --   index = 19,
            --   callback = "keymaps.goto_file_under_cursor",
            --   description = "Open the file under cursor in a new tab.",
            -- },
          },
        },
        inline = {
          adapter = "copilot",
        },
        cmd = {
          adapter = "copilot",
          -- adapter = "gemini-2.5-pro",
        },
      },
      adapters = {
        ["gemini-2.5-pro"] = function()
          return require("codecompanion.adapters").extend("gemini", {
            name = "gemini-2.5-pro",
            env = {
              api_key = "GEMINI_API_KEY"
            },
            schema = {
              model = {
                default = "gemini-2.5-pro-exp-03-25",
              },
            },
          })
        end,
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "CLAUDE_API_KEY",
            },
          })
        end,
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "claude-3.7-sonnet",
              },
            },
            system_prompt = prompts.SYSTEM_PROMPT,
          })
        end,
      },
      prompt_library = prompts.PROMPT_LIBRARY,
      extensions = {
        history = {
          enabled = true,
          opts = {
            -- Keymap to open history from chat buffer (default: gh)
            keymap = "<leader>ah",
            -- Keymap to save the current chat manually (when auto_save is disabled)
            save_chat_keymap = "sc",
            -- Save all chats by default (disable to save only manually using 'sc')
            auto_save = true,
            -- Number of days after which chats are automatically deleted (0 to disable)
            expiration_days = 0,
            -- Picker interface ("telescope" or "snacks" or "fzf-lua" or "default")
            picker = "telescope",
            ---Automatically generate titles for new chats
            auto_generate_title = true,
            title_generation_opts = {
              ---Adapter for generating titles (defaults to active chat's adapter)
              adapter = nil, -- e.g "copilot"
              ---Model for generating titles (defaults to active chat's model)
              model = nil, -- e.g "gpt-4o"
            },
            ---On exiting and entering neovim, loads the last chat on opening chat
            continue_last_chat = false,
            ---When chat is cleared with `gx` delete the chat from history
            delete_on_clearing_chat = false,
            ---Directory path to save the chats
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
            ---Enable detailed logging for history extension
            enable_logging = false,
          }
        }
      },
    })

    vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = "#f38ba8" })
  end,
}
