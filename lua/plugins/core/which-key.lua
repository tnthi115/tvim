-- Full spec: https://www.lazyvim.org/plugins/editor#which-keynvim

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
      { "<leader>lc", require("lazyvim.util").news.changelog, desc = "Changelog" },
      { "<leader>lr", require("lazyvim.util").root.info, desc = "Root Info" },
      { "<leader>lM", vim.cmd.messages, desc = "Display messages" },
    },
  },
}
