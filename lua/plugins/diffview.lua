return {
  {
    "sindrets/diffview.nvim",
    cmds = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    keys = {
      { "<leader>g,", "", desc = "diffview", mode = { "n", "v" } },
      -- This overrides lazyvim / snacks keymap
      -- { "<leader>gD", "<cmd>DiffviewOpen<CR>", desc = "Open Diffview" },
      { "<leader>g,o", "<cmd>DiffviewOpen<CR>", desc = "Open Diffview" },
      { "<leader>g,a", ":DiffviewOpen ", desc = "Open Diffview (with args)" },
      { "<leader>g,q", "<cmd>DiffviewClose<CR>", desc = "Close Diffview" },
      { "<leader>g,f", "<cmd>DiffviewToggleFiles<CR>", desc = "Toggle Diffview Files" },
      { "<leader>g,F", "<cmd>DiffviewFocusFiles<CR>", desc = "Focus Diffview Files" },
      { "<leader>g,r", "<cmd>DiffviewRefresh<CR>", desc = "Refresh Diffview" },
      { "<leader>g,h", ":DiffviewFileHistory ", desc = "Toggle Diffview File History", mode = { "n", "v" } },
    },
    opts = {
      default_args = {
        DiffviewOpen = { "--untracked-files=no", "--imply-local" },
      },
    },
  },
}
