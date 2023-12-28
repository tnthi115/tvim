-- https://github.com/m4xshen/hardtime.nvim
-- https://github.com/m4xshen/hardtime.nvim/issues/5

return {
  "m4xshen/hardtime.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  keys = { { "<leader>uH", "<cmd>Hardtime toggle<CR>", desc = "Toggle Hardtime" } },
  opts = {
    disable_mouse = false,
  },
}
