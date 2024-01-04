-- https://github.com/f-person/git-blame.nvim

return {
  "f-person/git-blame.nvim",
  cmd = { "GitBlameToggle", "GitBlameEnable", "GitBlameDisable" },
  keys = {
    { "<leader>uB", "<cmd>GitBlameToggle<CR>", desc = "Toggle Git Blame Virtual Text" },
    { "<leader>gB", "<cmd>GitBlameEnable<CR>", desc = "Enable Git Blame Virtual Text" },
  },
  opts = {
    enabled = false,
  },
}
