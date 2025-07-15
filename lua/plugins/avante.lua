-- https://github.com/yetone/avante.nvim

return {
  {
    "yetone/avante.nvim",
    enabled = true,
    -- event = "LazyFile",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- build = function()
    --   -- conditionally use the correct build system for the current OS
    --   if vim.fn.has "win32" == 1 then
    --     return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    --   else
    --     return "make BUILD_FROM_SOURCE=true"
    --   end
    -- end,
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      -- "echasnovski/mini.pick", -- for file_selector provider mini.pick
      -- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      -- "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "stevearc/dressing.nvim", -- for input provider dressing
      "folke/snacks.nvim", -- for input provider snacks
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
        keys = {
          -- suggested keymap
          { "<leader>v", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
    keys = {
      { "<leader>a", "", desc = "avante ai", mode = { "n", "v", "x" } },
      { "<leader>ax", "<cmd>AvanteClear<CR>", desc = "avante: clear chat history", mode = { "n", "v", "x" } },
      -- { "A", false },
    },
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      -- add any opts here
      -- for example
      provider = "copilot",
      auto_suggestions_provider = "copilot",
      -- https://models.dev/
      providers = {
        copilot = {
          -- TODO: see if this is possible
          -- default model is gpt-4o-2024-11-24
          model = "claude-3.7-sonnet", -- https://docs.github.com/en/copilot/using-github-copilot/ai-models/supported-ai-models-in-copilot#supported-ai-models-per-copilot-plan
          extra_request_body = {
            temperature = 0,
            -- max_completion_tokens = 1000000,
            max_completion_tokens = 8192,
            reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
          },
        },
        f5gpt = {
          __inherited_from = "openai",
          endpoint = "https://f5ai.pd.f5net.com/api/",
          display_name = "f5gpt/gpt-4o",
          model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
          api_key = os.getenv "OPENAI_API_KEY",
          extra_request_body = {
            temperature = 0.2,
            max_completion_tokens = 16384,
            reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
          },
        },
        f5gpt1 = {
          __inherited_from = "openai",
          endpoint = "https://f5ai.pd.f5net.com/api/",
          display_name = "f5gpt/gpt-4.1",
          model = "gpt-4.1", -- your desired model (or use gpt-4o, etc.)
          api_key = os.getenv "OPENAI_API_KEY",
          extra_request_body = {
            temperature = 0.2,
            max_completion_tokens = 32768,
            reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
          },
        },
        f5gpt2 = {
          __inherited_from = "openai",
          endpoint = "https://f5ai.pd.f5net.com/api/",
          display_name = "f5gpt/o3",
          model = "o3", -- your desired model (or use gpt-4o, etc.)
          api_key = os.getenv "OPENAI_API_KEY",
          extra_request_body = {
            temperature = 0.2,
            max_completion_tokens = 100000,
            reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
          },
        },
        f5gpt3 = {
          __inherited_from = "openai",
          endpoint = "https://f5ai.pd.f5net.com/api/",
          display_name = "f5gpt/gpt-4.1-mini",
          model = "gpt-4.1-mini", -- your desired model (or use gpt-4o, etc.)
          api_key = os.getenv "OPENAI_API_KEY",
          extra_request_body = {
            temperature = 0.2,
            max_completion_tokens = 32768,
            reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
          },
        },
        ollama = {
          endpoint = "http://127.0.0.1:11434", -- Note that there is no /v1 at the end.
          model = "mistral:7b-instruct",
        },
      },
      ---Specify the special dual_boost mode
      ---1. enabled: Whether to enable dual_boost mode. Default to false.
      ---2. first_provider: The first provider to generate response. Default to "openai".
      ---3. second_provider: The second provider to generate response. Default to "claude".
      ---4. prompt: The prompt to generate response based on the two reference outputs.
      ---5. timeout: Timeout in milliseconds. Default to 60000.
      ---How it works:
      --- When dual_boost is enabled, avante will generate two responses from the first_provider and second_provider respectively. Then use the response from the first_provider as provider1_output and the response from the second_provider as provider2_output. Finally, avante will generate a response based on the prompt and the two reference outputs, with the default Provider as normal.
      ---Note: This is an experimental feature and may not work as expected.
      dual_boost = {
        enabled = false,
        first_provider = "copilot",
        second_provider = "openai",
        prompt = "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
        timeout = 60000, -- Timeout in milliseconds
      },
      behaviour = {
        auto_suggestions = false, -- Experimental stage
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
        enable_token_counting = true, -- Whether to enable token counting. Default to true.
        auto_approve_tool_permissions = false, -- Default: show permission prompts for all tools
        -- Examples:
        -- auto_approve_tool_permissions = true,                -- Auto-approve all tools (no prompts)
        -- auto_approve_tool_permissions = {"bash", "replace_in_file"}, -- Auto-approve specific tools only

        -- Avante integration
        -- system_prompt as function ensures LLM always has latest MCP server state
        -- This is evaluated for every message, even in existing chats
        system_prompt = function()
          local hub = require("mcphub").get_hub_instance()
          return hub and hub:get_active_servers_prompt() or ""
        end,
        -- Using function prevents requiring mcphub before it's loaded
        custom_tools = function()
          return {
            require("mcphub.extensions.avante").mcp_tool(),
          }
        end,
      },
    },
  },
  {
    "saghen/blink.cmp",
    event = "BufRead Avante",
    dependencies = {
      "Kaiser-Yang/blink-cmp-avante",
      -- ... Other dependencies
    },
    opts = {
      sources = {
        -- Add 'avante' to the list
        default = { "avante" },
        providers = {
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
            opts = {
              -- options for blink-cmp-avante
            },
          },
        },
      },
    },
  },
  -- https://github.com/ravitemer/mcphub.nvim
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    cmd = "MCPHub",
    keys = {
      { "<leader>am", "<cmd>MCPHub<CR>", desc = "MCPHub" },
    },
    config = function()
      require("mcphub").setup()
    end,
  },
  --   {
  --     "yetone/avante.nvim",
  --     dependencies = {
  --       -- other dependencies
  --       "takeshid/avante-status.nvim",
  --     },
  --     opts = function(_, opts)
  --       opts.provider = require("avante-status").get_chat_provider {
  --         "copilot",
  --         "openai",
  --       }
  --       opts.auto_suggestions_provider = require("avante-status").get_suggestions_provider {
  --         "copilot",
  --         "openai",
  --       }
  --     end,
  --   },
  --   {
  --     "nvim-lualine/lualine.nvim",
  --     optional = true,
  --     event = "VeryLazy",
  --     opts = function(_, opts)
  --       table.insert(opts.sections.lualine_x, 2, require("avante-status.lualine").chat_component)
  --     end,
  --   },
}
