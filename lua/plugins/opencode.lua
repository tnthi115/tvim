-- There are many opencode.nvim projects currently on github: https://github.com/search?q=opencode.nvim&type=repositories

return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recommended for `ask()` and `select()`.
      -- Required for `snacks` provider.
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    config = function()
      -- see https://github.com/NickvanDyke/opencode.nvim/blob/main/lua/opencode/config.lua
      -- `opencode.nvim` passes options via a global variable instead of `setup()` for faster startup
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        provider = {
          enabled = "snacks",
          snacks = {
            auto_close = true,
            win = {
              position = "right",
              enter = false,
              wo = {
                winbar = "",
              },
              bo = {
                filetype = "opencode_terminal",
              },
            },
          },
        },
      }

      -- Required for `opts.events.reload`
      vim.opt.autoread = true
    end,
    keys = {
      { "<leader>o", "", desc = "opencode", mode = { "n", "x" } },
      {
        "<leader>oa",
        function()
          require("opencode").ask("@this: ", { submit = true })
        end,
        desc = "Ask opencode",
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
        desc = "Select action...",
        mode = { "n", "x" },
      },
      {
        "<leader>ot",
        function()
          require("opencode").toggle()
        end,
        desc = "Toggle terminal",
        mode = { "n", "t" },
      },
      {
        "<leader>on",
        function()
          require("opencode").command "session.new"
        end,
        desc = "New session",
      },
      {
        "<leader>oi",
        function()
          require("opencode").command "session.interrupt"
        end,
        desc = "Interrupt session",
      },
      {
        "<S-C-u>",
        function()
          require("opencode").command "session.half.page.up"
        end,
        desc = "Scroll opencode up",
        mode = "n",
      },
      {
        "<S-C-d>",
        function()
          require("opencode").command "session.half.page.down"
        end,
        desc = "Scroll opencode down",
        mode = "n",
      },
    },
  },
}
