return {
  {
    "akinsho/git-conflict.nvim",
    event = "GitConflictDetected",
    version = "*",
    command = {
      "GitConflictChooseOurs",
      "GitConflictChooseTheirs",
      "GitConflictChooseBoth",
      "GitConflictChooseNone",
      "GitConflictNextConflict",
      "GitConflictPrevConflict",
      "GitConflictListQf",
    },
    keys = {
      { "<leader>ghc", "<cmd>GitConflictListQf", desc = "Git Conflict List" },
    },
    config = function()
      require("git-conflict").setup {}

      vim.api.nvim_create_autocmd("User", {
        pattern = "GitConflictDetected",
        callback = function()
          vim.notify("Conflict detected in " .. vim.fn.expand "<afile>")
          vim.keymap.set("n", "cww", function()
            engage.conflict_buster()
            create_buffer_local_mappings()
          end)
        end,
      })
    end,
  },
}
