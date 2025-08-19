-- There are many opencode.nvim projects currently on github: https://github.com/search?q=opencode.nvim&type=repositories

return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      { "folke/snacks.nvim", opts = { input = { enabled = true } } },
    },
    ---@type opencode.Config
    opts = {
      -- Set these according to https://models.dev/
      provider_id = "github-copilot",
      model_id = "gpt-5",
      terminal = {
        env = {
          OPENCODE_THEME = "tymon-kanagawa",
        },
      },
    },
    keys = {
      -- Recommended keymaps
      {
        "<leader>oa",
        function()
          require("opencode").ask "@cursor: "
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
        "<leader>ot",
        function()
          require("opencode").toggle()
        end,
        desc = "Toggle embedded opencode",
      },
      {
        "<leader>on",
        function()
          require("opencode").command "session_new"
        end,
        desc = "New session",
      },
      {
        "<leader>oy",
        function()
          require("opencode").command "messages_copy"
        end,
        desc = "Copy last message",
      },
      {
        "<S-C-u>",
        function()
          require("opencode").command "messages_half_page_up"
        end,
        desc = "Scroll messages up",
      },
      {
        "<S-C-d>",
        function()
          require("opencode").command "messages_half_page_down"
        end,
        desc = "Scroll messages down",
      },
      {
        "<leader>op",
        function()
          require("opencode").select_prompt()
        end,
        desc = "Select prompt",
        mode = { "n", "v" },
      },
      -- Example: keymap for custom prompt
      {
        "<leader>oe",
        function()
          require("opencode").prompt "Explain @cursor and its context"
        end,
        desc = "Explain code near cursor",
      },
    },
  },
}
