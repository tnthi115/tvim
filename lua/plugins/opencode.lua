-- There are many opencode.nvim projects currently on github: https://github.com/search?q=opencode.nvim&type=repositories

return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recommended for `ask()` and `select()`.
      -- Required for default `toggle()` implementation.
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    config = function()
      -- see https://github.com/NickvanDyke/opencode.nvim/blob/main/lua/opencode/config.lua
      -- `opencode.nvim` passes options via a global variable instead of `setup()` for faster startup
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        auto_reload = true,
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

      -- Required for `vim.g.opencode_opts.auto_reload`
      vim.opt.autoread = true
    end,
    keys = {
      -- Recommended keymaps
      { "<leader>o", "opencode", desc = "opencode", mode = { "n", "x" } },
      {
        "<leader>oa",
        function()
          require("opencode").ask("@this: ", { submit = true })
        end,
        desc = "Ask about this",
        mode = { "n", "x" },
      },
      {
        "<leader>o+",
        function()
          require("opencode").prompt "@this"
        end,
        desc = "Add this",
        mode = { "n", "x" },
      },
      {
        "<leader>oe",
        function()
          require("opencode").prompt("Explain @this and its context", { submit = true })
        end,
        desc = "Explain this",
        mode = { "n", "x" },
      },
      {
        "<leader>os",
        function()
          require("opencode").select()
        end,
        desc = "Select prompt",
        mode = { "n", "x" },
      },
      {
        "<leader>ot",
        function()
          require("opencode").toggle()
        end,
        desc = "Toggle embedded",
      },
      {
        "<leader>on",
        function()
          require("opencode").command "session_new"
        end,
        desc = "New session",
      },
      {
        "<leader>oi",
        function()
          require("opencode").command "session_interrupt"
        end,
        desc = "Interrupt session",
        mode = "n",
      },
      {
        "<S-C-u>",
        function()
          require("opencode").command "messages_half_page_up"
        end,
        desc = "Messages half page up",
        mode = "n",
      },
      {
        "<S-C-d>",
        function()
          require("opencode").command "messages_half_page_down"
        end,
        desc = "Messages half page down",
        mode = "n",
      },
    },
  },
}
