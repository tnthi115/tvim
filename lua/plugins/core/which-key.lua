-- Full spec: https://www.lazyvim.org/plugins/editor#which-keynvim

local lazyvim_util = require "lazyvim.util"

return {
  "folke/which-key.nvim",
  vscode = true,
  opts = {
    preset = "modern", -- "classic" | "modern" | "helix"
    win = {
      border = "single",
    },
    spec = {
      { "<leader>l", group = "lazyvim" },
      { "<leader>ll", "<cmd>Lazy<CR>", desc = "Lazy" },
      { "<leader>lx", "<cmd>LazyExtras<CR>", desc = "LazyExtras" },
      { "<leader>lc", lazyvim_util.news.changelog, desc = "Changelog" },
      { "<leader>lr", lazyvim_util.root.info, desc = "Root Info" },
      { "<leader>lM", vim.cmd.messages, desc = "Display messages" },
    },
  },
}
