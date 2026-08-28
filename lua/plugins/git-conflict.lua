return {
  {
    "akinsho/git-conflict.nvim",
    event = "VeryLazy",
    version = "*",
    cmd = {
      "GitConflictChooseOurs",
      "GitConflictChooseTheirs",
      "GitConflictChooseBoth",
      "GitConflictChooseNone",
      "GitConflictNextConflict",
      "GitConflictPrevConflict",
      "GitConflictListQf",
    },
    keys = {
      { "<leader>ghc", "<cmd>GitConflictListQf<CR>", desc = "Git Conflict List" },
    },
    config = function()
      require("git-conflict").setup {}

      vim.api.nvim_create_autocmd("User", {
        pattern = "GitConflictDetected",
        callback = function()
          vim.notify("Conflict detected in " .. vim.fn.expand "<afile>")
        end,
      })
    end,
  },
}
