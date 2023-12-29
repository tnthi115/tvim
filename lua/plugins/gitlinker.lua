-- https://github.com/linrongbin16/gitlinker.nvim

return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.window = {
        border = "single",
      }
      opts.defaults["<leader>gL"] = { name = "+gitlinker" }
    end,
  },
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    keys = {
      { mode = { "n", "v" }, "<leader>gLl", "<cmd>GitLink<CR>", desc = "Copy /blob URL to Clipboard" },
      { mode = { "n", "v" }, "<leader>gLL", "<cmd>GitLink!<CR>", desc = "Open /blob URL in Browser" },
      { mode = { "n", "v" }, "<leader>gLb", "<cmd>GitLink blame<CR>", desc = "Copy /blame URL to Clipboard" },
      { mode = { "n", "v" }, "<leader>gLB", "<cmd>GitLink! blame<CR>", desc = "Open /blame URL in Browser" },
    },
    opts = {},
  },
}
