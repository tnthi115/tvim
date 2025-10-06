-- There are many opencode.nvim projects currently on github: https://github.com/search?q=opencode.nvim&type=repositories

return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      { "folke/snacks.nvim", opts = { input = { enabled = true } } },
    },
    config = function()
      -- `opencode.nvim` passes options via a global variable instead of `setup()` for faster startup
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Set these according to https://models.dev/
        provider_id = "github-copilot",
        -- model_id = "gpt-5",
        ---@diagnostic disable-next-line: missing-fields
        terminal = {
          env = {
            OPENCODE_THEME = "tymon-kanagawa",
          },
          win = {
            position = "right",
          },
        },
      }
    end,
    keys = {
      -- Recommended keymaps
      { "<leader>o", "opencode", desc = "opencode", mode = { "n", "v" } },
      {
        "<leader>ot",
        function()
          require("opencode").toggle()
        end,
        desc = "Toggle embedded",
      },
      {
        "<leader>oA",
        function()
          require("opencode").ask()
        end,
        desc = "Ask",
        mode = "n",
      },
      {
        "<leader>oa",
        function()
          require("opencode").ask "@cursor: "
        end,
        desc = "Ask about this",
        mode = "n",
      },
      {
        "<leader>oa",
        function()
          require("opencode").ask "@selection: "
        end,
        desc = "Ask about selection",
        mode = "v",
      },
      {
        "<leader>oe",
        function()
          require("opencode").prompt "Explain @cursor and its context"
        end,
        desc = "Explain this code",
        mode = "n",
      },
      {
        "<leader>o+",
        function()
          require("opencode").prompt("@buffer", { append = true })
        end,
        desc = "Add buffer to prompt",
        mode = "n",
      },
      {
        "<leader>o+",
        function()
          require("opencode").prompt("@selection", { append = true })
        end,
        desc = "Add selection to prompt",
        mode = "v",
      },
      {
        "<leader>on",
        function()
          require("opencode").command "session_new"
        end,
        desc = "New session",
      },
      {
        "<S-C-u>",
        function()
          require("opencode").command "messages_half_page_up"
        end,
        desc = "Messages half page up",
      },
      {
        "<S-C-d>",
        function()
          require("opencode").command "messages_half_page_down"
        end,
        desc = "Messages half page down",
      },
      {
        "<leader>os",
        function()
          require("opencode").select()
        end,
        desc = "Select prompt",
        mode = { "n", "v" },
      },
    },
  },
}
