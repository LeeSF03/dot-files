-- This is custom system prompt for Copilot adapter
-- Base on https://github.com/olimorris/codecompanion.nvim/blob/e7d931ae027f9fdca2bd7c53aa0a8d3f8d620256/lua/codecompanion/config.lua#L639 and https://github.com/CopilotC-Nvim/CopilotChat.nvim/blob/d43fab67c328946fbf8e24fdcadfdb5410517e1f/lua/CopilotChat/prompts.lua#L5
local SYSTEM_PROMPT = string.format(
  [[You are an AI programming assistant named "GitHub Copilot".
You are currently plugged in to the Neovim text editor on a user's machine.

Your tasks include:
- Answering general programming questions.
- Explaining how the code in a Neovim buffer works.
- Reviewing the selected code in a Neovim buffer.
- Generating unit tests for the selected code.
- Proposing fixes for problems in the selected code.
- Scaffolding code for a new workspace.
- Finding relevant code to the user's query.
- Proposing fixes for test failures.
- Answering questions about Neovim.
- Ask how to do something in the terminal
- Explain what just happened in the terminal
- Running tools.

You must:
- Follow the user's requirements carefully and to the letter.
- Keep your answers short and impersonal, especially if the user responds with context outside of your tasks.
- Minimize other prose.
- Use Markdown formatting in your answers.
- Include the programming language name at the start of the Markdown code blocks.
- Avoid line numbers in code blocks.
- Avoid wrapping the whole response in triple backticks.
- Only return code that's relevant to the task at hand. You may not need to return all of the code that the user has shared.
- Only return modified or relevant parts of code, not the full code, unless the user specifically asks for the complete code. Focus on showing only the changes needed or the specific sections that answer the user's query.
- The user works in an IDE called Neovim which has a concept for editors with open files, integrated unit test support, an output pane that shows the output of running the code as well as an integrated terminal.
- The user is working on a %s machine. Please respond with system specific commands if applicable.

When given a task:
1. Think step-by-step and describe your plan for what to build in pseudocode, written out in great detail, unless asked not to do so.
2. Output the code in a single code block.
3. You should always generate short suggestions for the next user turns that are relevant to the conversation.
4. You can only give one reply for each conversation turn.
5. The active document is the source code the user is looking at right now.
]],
  vim.loop.os_uname().sysname
)
local COPILOT_EXPLAIN = string.format(
  [[You are a world-class coding tutor. Your code explanations perfectly balance high-level concepts and granular details. Your approach ensures that students not only understand how to write code, but also grasp the underlying principles that guide effective programming.
When asked for your name, you must respond with "GitHub Copilot".
Follow the user's requirements carefully & to the letter.
Your expertise is strictly limited to software development topics.
Follow Microsoft content policies.
Avoid content that violates copyrights.
For questions not related to software development, simply give a reminder that you are an AI programming assistant.
Keep your answers short and impersonal.
Use Markdown formatting in your answers.
Make sure to include the programming language name at the start of the Markdown code blocks.
Avoid wrapping the whole response in triple backticks.
The user works in an IDE called Neovim which has a concept for editors with open files, integrated unit test support, an output pane that shows the output of running the code as well as an integrated terminal.
The active document is the source code the user is looking at right now.
You can only give one reply for each conversation turn.

Additional Rules
Think step by step:
1. Examine the provided code selection and any other context like user question, related errors, project details, class definitions, etc.
2. If you are unsure about the code, concepts, or the user's question, ask clarifying questions.
3. If the user provided a specific question or error, answer it based on the selected code and additional provided context. Otherwise focus on explaining the selected code.
4. Provide suggestions if you see opportunities to improve code readability, performance, etc.

Focus on being clear, helpful, and thorough without assuming extensive prior knowledge.
Use developer-friendly terms and analogies in your explanations.
Identify 'gotchas' or less obvious parts of the code that might trip up someone new.
Provide clear and relevant examples aligned with any provided context.
]]
)
local COPILOT_REVIEW = string.format(
  [[Your task is to review the provided code snippet, focusing specifically on its readability and maintainability.
Identify any issues related to:
- Naming conventions that are unclear, misleading or doesn't follow conventions for the language being used.
- The presence of unnecessary comments, or the lack of necessary ones.
- Overly complex expressions that could benefit from simplification.
- High nesting levels that make the code difficult to follow.
- The use of excessively long names for variables or functions.
- Any inconsistencies in naming, formatting, or overall coding style.
- Repetitive code patterns that could be more efficiently handled through abstraction or optimization.

Your feedback must be concise, directly addressing each identified issue with:
- A clear description of the problem.
- A concrete suggestion for how to improve or correct the issue.
  
Format your feedback as follows:
- Explain the high-level issue or problem briefly.
- Provide a specific suggestion for improvement.
 
If the code snippet has no readability issues, simply confirm that the code is clear and well-written as is.
]]
)
local COPILOT_REFACTOR = string.format(
  [[Your task is to refactor the provided code snippet, focusing specifically on its readability and maintainability.
Identify any issues related to:
- Naming conventions that are unclear, misleading or doesn't follow conventions for the language being used.
- The presence of unnecessary comments, or the lack of necessary ones.
- Overly complex expressions that could benefit from simplification.
- High nesting levels that make the code difficult to follow.
- The use of excessively long names for variables or functions.
- Any inconsistencies in naming, formatting, or overall coding style.
- Repetitive code patterns that could be more efficiently handled through abstraction or optimization.
]]
)
local AGENT_PROMPT = string.format(
  [[You are an agent, please keep going until the user's query is completely resolved, before ending your turn and yielding back to the user. Only terminate your turn when you are sure that the problem is solved. If you are not sure about file content or codebase structure pertaining to the user's request, use your tools to read files and gather the relevant information: do NOT guess or make up an answer. You MUST plan extensively before each function call, and reflect extensively on the outcomes of the previous function calls. DO NOT do this entire process by making function calls only, as this can impair your ability to solve the problem and think insightfully.
]]
)

local PROMPT_LIBRARY = {
  -- Custom the default prompt
  ["Generate a Commit Message"] = {
    prompts = {
      {
        role = "user",
        content = function()
          return "Write commit message with commitizen convention. Write clear, informative commit messages that explain the 'what' and 'why' behind changes, not just the 'how'."
            .. "\n\n```\n"
            .. vim.fn.system("git diff")
            .. "\n```"
        end,
        opts = {
          contains_code = true,
        },
      },
    },
  },
  ["Explain"] = {
    strategy = "chat",
    description = "Explain how code in a buffer works",
    opts = {
      default_prompt = true,
      modes = { "v" },
      short_name = "explain",
      auto_submit = true,
      user_prompt = false,
      stop_context_insertion = true,
    },
    prompts = {
      {
        role = "system",
        content = COPILOT_EXPLAIN,
        opts = {
          visible = false,
        },
      },
      {
        role = "user",
        content = function(context)
          local actions = require("codecompanion.helpers.actions")
          local code = actions.get_code(context.start_line, context.end_line)

          return "Please explain how the following code works:\n\n```"
            .. context.filetype
            .. "\n"
            .. code
            .. "\n```\n\n"
        end,
        opts = {
          contains_code = true,
        },
      },
    },
  },
  ["Explain Code"] = {
    strategy = "chat",
    description = "Explain how code works",
    opts = {
      short_name = "explain-code",
      auto_submit = false,
      is_slash_cmd = true,
    },
    prompts = {
      {
        role = "system",
        content = COPILOT_EXPLAIN,
        opts = {
          visible = false,
        },
      },
      {
        role = "user",
        content = [[Please explain how the following code works.]],
      },
    },
  },
  -- Add custom prompts
  ["Generate a Commit Message for Staged"] = {
    strategy = "chat",
    description = "Generate a commit message for staged change",
    opts = {
      short_name = "staged-commit",
      auto_submit = true,
      is_slash_cmd = true,
    },
    prompts = {
      {
        role = "user",
        content = function()
          return "Write commit message for the change with commitizen convention. Write clear, informative commit messages that explain the 'what' and 'why' behind changes, not just the 'how'."
            .. "\n\n```\n"
            .. vim.fn.system("git diff --staged")
            .. "\n```"
        end,
        opts = {
          contains_code = true,
        },
      },
    },
  },
  ["Inline Document"] = {
    strategy = "inline",
    description = "Add documentation for code.",
    opts = {
      modes = { "v" },
      short_name = "inline-doc",
      auto_submit = true,
      user_prompt = false,
      stop_context_insertion = true,
    },
    prompts = {
      {
        role = "user",
        content = function(context)
          local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

          return "Please provide documentation in comment code for the following code and suggest to have better naming to improve readability.\n\n```"
            .. context.filetype
            .. "\n"
            .. code
            .. "\n```\n\n"
        end,
        opts = {
          contains_code = true,
        },
      },
    },
  },
  ["Document"] = {
    strategy = "chat",
    description = "Write documentation for code.",
    opts = {
      modes = { "v" },
      short_name = "doc",
      auto_submit = true,
      user_prompt = false,
      stop_context_insertion = true,
    },
    prompts = {
      {
        role = "user",
        content = function(context)
          local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

          return "Please brief how it works and provide documentation in comment code for the following code. Also suggest to have better naming to improve readability.\n\n```"
            .. context.filetype
            .. "\n"
            .. code
            .. "\n```\n\n"
        end,
        opts = {
          contains_code = true,
        },
      },
    },
  },
  ["Review"] = {
    strategy = "chat",
    description = "Review the provided code snippet.",
    opts = {
      modes = { "v" },
      short_name = "review",
      auto_submit = true,
      user_prompt = false,
      stop_context_insertion = true,
    },
    prompts = {
      {
        role = "system",
        content = COPILOT_REVIEW,
        opts = {
          visible = false,
        },
      },
      {
        role = "user",
        content = function(context)
          local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

          return "Please review the following code and provide suggestions for improvement then refactor the following code to improve its clarity and readability:\n\n```"
            .. context.filetype
            .. "\n"
            .. code
            .. "\n```\n\n"
        end,
        opts = {
          contains_code = true,
        },
      },
    },
  },
  ["Review Code"] = {
    strategy = "chat",
    description = "Review code and provide suggestions for improvement.",
    opts = {
      short_name = "review-code",
      auto_submit = false,
      is_slash_cmd = true,
    },
    prompts = {
      {
        role = "system",
        content = COPILOT_REVIEW,
        opts = {
          visible = false,
        },
      },
      {
        role = "user",
        content = "Please review the following code and provide suggestions for improvement then refactor the following code to improve its clarity and readability.",
      },
    },
  },
  ["Refactor"] = {
    strategy = "inline",
    description = "Refactor the provided code snippet.",
    opts = {
      modes = { "v" },
      short_name = "refactor",
      auto_submit = true,
      user_prompt = false,
      stop_context_insertion = true,
    },
    prompts = {
      {
        role = "system",
        content = COPILOT_REFACTOR,
        opts = {
          visible = false,
        },
      },
      {
        role = "user",
        content = function(context)
          local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

          return "Please refactor the following code to improve its clarity and readability:\n\n```"
            .. context.filetype
            .. "\n"
            .. code
            .. "\n```\n\n"
        end,
        opts = {
          contains_code = true,
        },
      },
    },
  },
  ["Refactor Code"] = {
    strategy = "chat",
    description = "Refactor the provided code snippet.",
    opts = {
      short_name = "refactor-code",
      auto_submit = false,
      is_slash_cmd = true,
    },
    prompts = {
      {
        role = "system",
        content = COPILOT_REFACTOR,
        opts = {
          visible = false,
        },
      },
      {
        role = "user",
        content = "Please refactor the following code to improve its clarity and readability.",
      },
    },
  },
  ["Naming"] = {
    strategy = "inline",
    description = "Give betting naming for the provided code snippet.",
    opts = {
      modes = { "v" },
      short_name = "naming",
      auto_submit = true,
      user_prompt = false,
      stop_context_insertion = true,
    },
    prompts = {
      {
        role = "user",
        content = function(context)
          local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

          return "Please provide better names for the following variables and functions:\n\n```"
            .. context.filetype
            .. "\n"
            .. code
            .. "\n```\n\n"
        end,
        opts = {
          contains_code = true,
        },
      },
    },
  },
  ["Better Naming"] = {
    strategy = "chat",
    description = "Give betting naming for the provided code snippet.",
    opts = {
      short_name = "better-naming",
      auto_submit = false,
      is_slash_cmd = true,
    },
    prompts = {
      {
        role = "user",
        content = "Please provide better names for the following variables and functions.",
      },
    },
  },
}

return {
  SYSTEM_PROMPT = SYSTEM_PROMPT,
  PROMPT_LIBRARY = PROMPT_LIBRARY,
  AGENT_PROMPT = AGENT_PROMPT,
}
