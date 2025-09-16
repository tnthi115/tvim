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
        terminal = {
          env = {
            OPENCODE_THEME = "tymon-kanagawa",
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
        desc = "Toggle opencode",
      },
      {
        "<leader>oA",
        function()
          require("opencode").ask()
        end,
        desc = "Ask opencode",
        mode = "n",
      },
      {
        "<leader>oa",
        function()
          require("opencode").ask "@cursor: "
        end,
        desc = "Ask opencode about this",
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
          require("opencode").command "session_new"
        end,
        desc = "New opencode session",
      },
      {
        "<leader>oy",
        function()
          require("opencode").command "messages_copy"
        end,
        desc = "Copy last opencode response",
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
          require("opencode").select_prompt()
        end,
        desc = "Select opencode prompt",
        mode = { "n", "v" },
      },
    },
  },
}
