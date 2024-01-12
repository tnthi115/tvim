-- https://github.com/linrongbin16/gitlinker.nvim

return {
  "linrongbin16/gitlinker.nvim",
  dependencies = {
    {
      "folke/which-key.nvim",
      opts = function(_, opts)
        opts.defaults["<leader>gL"] = { name = "+gitlinker" }
      end,
    },
  },
  cmd = "GitLink",
  keys = {
    { mode = { "n", "v" }, "<leader>gLl", "<cmd>GitLink<CR>", desc = "Copy /blob URL to Clipboard" },
    { mode = { "n", "v" }, "<leader>gLL", "<cmd>GitLink!<CR>", desc = "Open /blob URL in Browser" },
    { mode = { "n", "v" }, "<leader>gLb", "<cmd>GitLink blame<CR>", desc = "Copy /blame URL to Clipboard" },
    { mode = { "n", "v" }, "<leader>gLB", "<cmd>GitLink! blame<CR>", desc = "Open /blame URL in Browser" },
  },
  opts = {},
}
