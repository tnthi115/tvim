-- https://github.com/olimorris/codecompanion.nvim?tab=readme-ov-file

return {
  {
    "olimorris/codecompanion.nvim",
    enabled = true,
    event = "LazyFile",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- "nvim-telescope/telescope.nvim", -- Optional
      "stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
    },
    keys = {
      { "<leader>a,", "", desc = "+CodeCompanion", mode = { "n", "v" } },
      { "<leader>a,a", ":CodeCompanion ", mode = { "n", "x", "v" } },
      { "<leader>a,o", "<cmd>CodeCompanionActions<CR>", desc = "Open Actions" },
      { "<leader>a,c", "<cmd>CodeCompanionChat<CR>", desc = "Open New Chat Buffer" },
      { "<leader>a,u", "<cmd>CodeCompanionChat Toggle<CR>", desc = "Toggle Chat Buffer" },
      { "<leader>a,:", ":CodeCompanionCmd ", desc = "Create Neovim commands in commandline mode" },
      {
        "<leader>a,v",
        "<cmd>CodeCompanionChat Add<CR>",
        desc = "Add Selection to Chat Buffer",
        mode = { "n", "x", "v" },
      },
    },
    opts = {
      -- https://codecompanion.olimorris.dev/configuration/prompt-library
      adapters = {
        f5gpt = function()
          return require("codecompanion.adapters").extend "openai_compatible",
            {
              name = "f5gpt",
              env = {
                url = "https://f5ai.pd.f5net.com",
                api_key = os.getenv "OPENAI_API_KEY",
                chat_url = "/api/chat/completions",
              },
              schema = {
                model = {
                  default = "gpt-4o",
                },
                temperature = {
                  order = 2,
                  mapping = "parameters",
                  type = "number",
                  optional = true,
                  default = 0.8,
                  desc = "What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top_p but not both.",
                  validate = function(n)
                    return n >= 0 and n <= 2, "Must be between 0 and 2"
                  end,
                },
                max_completion_tokens = {
                  order = 3,
                  mapping = "parameters",
                  type = "integer",
                  optional = true,
                  default = nil,
                  desc = "An upper bound for the number of tokens that can be generated for a completion.",
                  validate = function(n)
                    return n > 0, "Must be greater than 0"
                  end,
                },
                stop = {
                  order = 4,
                  mapping = "parameters",
                  type = "string",
                  optional = true,
                  default = nil,
                  desc = "Sets the stop sequences to use. When this pattern is encountered the LLM will stop generating text and return. Multiple stop patterns may be set by specifying multiple separate stop parameters in a modelfile.",
                  validate = function(s)
                    return s:len() > 0, "Cannot be an empty string"
                  end,
                },
                logit_bias = {
                  order = 5,
                  mapping = "parameters",
                  type = "map",
                  optional = true,
                  default = nil,
                  desc = "Modify the likelihood of specified tokens appearing in the completion. Maps tokens (specified by their token ID) to an associated bias value from -100 to 100. Use https://platform.openai.com/tokenizer to find token IDs.",
                  subtype_key = {
                    type = "integer",
                  },
                  subtype = {
                    type = "integer",
                    validate = function(n)
                      return n >= -100 and n <= 100, "Must be between -100 and 100"
                    end,
                  },
                },
              },
            }
        end,
        -- ollama by default uses starcoder2:7b
        deepseekcoder = function()
          return require("codecompanion.adapters").extend "ollama",
            {
              name = "deepseekcoder",
              schema = {
                model = {
                  default = "deepseek-coder:6.7b",
                },
              },
            }
        end,
        -- Change ollama's default model
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "mistral:7b-instruct",
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          -- adapter = "ollama",
          adapter = "f5gpt",
          -- slash_commands = {
          -- ["buffer"] = {
          --   opts = {
          --     provider = "fzf_lua",
          --   },
          -- },
          -- ["file"] = {
          --   opts = {
          --     provider = "fzf_lua",
          --   },
          -- },
          -- },
        },
        inline = {
          -- adapter = "ollama",
          adapter = "f5gpt",
        },
        agent = {
          -- adapter = "ollama",
          adapter = "f5gpt",
        },
      },
    },
  },
}
