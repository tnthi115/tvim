return {
  {
    "sindrets/diffview.nvim",
    cmds = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh" },
    keys = {
      { "<leader>g,", "", desc = "diffview" },
      { "<leader>g,o", "<cmd>DiffviewOpen<CR>", desc = "Open Diffview" },
      { "<leader>g,a", ":DiffviewOpen ", desc = "Open Diffview (with args)" },
      { "<leader>g,q", "<cmd>DiffviewClose<CR>", desc = "Close Diffview" },
      { "<leader>g,f", "<cmd>DiffviewToggleFiles<CR>", desc = "Toggle Diffview Files" },
      { "<leader>g,F", "<cmd>DiffviewFocusFiles<CR>", desc = "Focus Diffview Files" },
      { "<leader>g,r", "<cmd>DiffviewRefresh<CR>", desc = "Refresh Diffview" },
    },
  },
}
