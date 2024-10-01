-- https://github.com/olimorris/codecompanion.nvim?tab=readme-ov-file

return {
  {
    "olimorris/codecompanion.nvim",
    event = "LazyFile",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- "nvim-telescope/telescope.nvim", -- Optional
      "stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
      {
        "folke/which-key.nvim",
        opts = function(_, opts)
          local wk = require "which-key"
          wk.add { "<leader>a", group = "ai (CodeCompanion)" }
        end,
      },
    },
    keys = {
      { "<leader>aa", ":CodeCompanion", mode = { "n", "x", "v" } },
      { "<leader>ao", "<cmd>CodeCompanionActions<CR>", desc = "Open Actions" },
      { "<leader>ac", "<cmd>CodeCompanionChat<CR>", desc = "Open New Chat Buffer" },
      { "<leader>au", "<cmd>CodeCompanionChat Toggle<CR>", desc = "Toggle Chat Buffer" },
      {
        "<leader>aA",
        "<cmd>CodeCompanionChat Add<CR>",
        desc = "Add Selection to Chat Buffer",
        mode = { "n", "x", "v" },
      },
    },
    opts = {
      adapters = {
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
          adapter = "ollama",
          slash_commands = {
            ["buffer"] = {
              opts = {
                provider = "fzf_lua",
              },
            },
            ["file"] = {
              opts = {
                provider = "fzf_lua",
              },
            },
          },
        },
        inline = {
          adapter = "ollama",
        },
        agent = {
          adapter = "ollama",
        },
      },
    },
  },
}
