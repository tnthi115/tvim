-- https://github.com/ThePrimeagen/git-worktree.nvim

return {
  "ThePrimeagen/git-worktree.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    {
      mode = "n",
      "<leader>gw",
      "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
      desc = "Checkout Worktree",
    },
    {
      mode = "n",
      "<leader>gW",
      "<cmd>lua require('telescope').extensions.git_workree.create_git_worktree()<CR>",
      desc = "Create Worktree",
    },
  },
  config = function()
    require("git-worktree").setup {
      change_directory_command = "cd", -- default: "cd",
      update_on_change = true, -- default: true,
      update_on_change_command = "e .", -- default: "e .",
      clearjumps_on_change = true, -- default: true,
      autopush = false, -- default: false,
    }
    require("telescope").load_extension "git_worktree"
  end,
}
