-- https://github.com/linrongbin16/gitlinker.nvim

return {
  "linrongbin16/gitlinker.nvim",
  dependencies = {
    {
      "folke/which-key.nvim",
      opts = function(_, opts)
        local wk = require "which-key"
        wk.add { "<leader>gk", group = "gitlinker", mode = { "n", "v" } }
      end,
    },
  },
  cmd = "GitLink",
  keys = {
    { mode = { "n", "v" }, "<leader>gkl", "<cmd>GitLink<CR>", desc = "Copy /blob URL to Clipboard" },
    { mode = { "n", "v" }, "<leader>gkL", "<cmd>GitLink!<CR>", desc = "Open /blob URL in Browser" },
    { mode = { "n", "v" }, "<leader>gkb", "<cmd>GitLink blame<CR>", desc = "Copy /blame URL to Clipboard" },
    { mode = { "n", "v" }, "<leader>gkB", "<cmd>GitLink! blame<CR>", desc = "Open /blame URL in Browser" },
    { mode = { "n", "v" }, "<leader>gkB", "<cmd>GitLink! blame<CR>", desc = "Open /blame URL in Browser" },
    {
      mode = { "n", "v" },
      "<leader>gkd",
      function()
        require("gitlinker").link { router_type = "default_branch" }
      end,
      desc = "GitLink default_branch",
    },
    {
      mode = { "n", "v" },
      "<leader>gkD",
      function()
        require("gitlinker").link {
          router_type = "default_branch",
          action = require("gitlinker.actions").system,
        }
      end,
      desc = "GitLink! default_branch",
    },
    {
      mode = { "n", "v" },
      "<leader>gkc",
      function()
        require("gitlinker").link { router_type = "current_branch" }
      end,
      desc = "GitLink current_branch",
    },
    {
      mode = { "n", "v" },
      "<leader>gkC",
      function()
        require("gitlinker").link {
          router_type = "current_branch",
          action = require("gitlinker.actions").system,
        }
      end,
      desc = "GitLink! current_branch",
    },
  },
  opts = {},
}
