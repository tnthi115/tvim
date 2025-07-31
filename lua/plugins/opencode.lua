-- There are many opencode.nvim projects currently on github: https://github.com/search?q=opencode.nvim&type=repositories

return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      "folke/snacks.nvim",
      {
        -- Optional blink.cmp integration for context placeholders
        "saghen/blink.cmp",
        opts = {
          sources = {
            providers = {
              opencode = {
                module = "opencode.cmp.blink",
              },
            },
            per_filetype = {
              opencode_ask = { "opencode", "buffer" },
            },
          },
        },
      },
    },
    ---@type opencode.Config
    opts = {
      -- Set these according to https://models.dev/
      provider_id = "github-copilot",
      model_id = "gpt-4.1",
    },
    keys = {
      { "<leader>o", "", desc = "Opencode", mode = { "n", "v" } },
      {
        "<leader>ot",
        function()
          require("opencode").toggle()
        end,
        desc = "Toggle embedded opencode",
      },
      {
        "<leader>oa",
        function()
          require("opencode").ask()
        end,
        desc = "Ask opencode",
        mode = "n",
      },
      {
        "<leader>oa",
        function()
          require("opencode").ask "@selection: "
        end,
        desc = "Ask opencode about selection",
        mode = "v",
      },
      {
        "<leader>on",
        function()
          require("opencode").create_session()
        end,
        desc = "New session",
      },
      {
        "<leader>oe",
        function()
          require("opencode").prompt "Explain @cursor and its context"
        end,
        desc = "Explain code near cursor",
      },
      {
        "<leader>or",
        function()
          require("opencode").prompt "Review @file for correctness and readability"
        end,
        desc = "Review file",
      },
      {
        "<leader>of",
        function()
          require("opencode").prompt "Fix these @diagnostics"
        end,
        desc = "Fix errors",
      },
      {
        "<leader>oo",
        function()
          require("opencode").prompt "Optimize @selection for performance and readability"
        end,
        desc = "Optimize selection",
        mode = "v",
      },
      {
        "<leader>od",
        function()
          require("opencode").prompt "Add documentation comments for @selection"
        end,
        desc = "Document selection",
        mode = "v",
      },
      {
        "<leader>ot",
        function()
          require("opencode").prompt "Add tests for @selection"
        end,
        desc = "Test selection",
        mode = "v",
      },
    },
  },
}
