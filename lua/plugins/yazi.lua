-- https://github.com/DreamMaoMao/yazi.nvim

return {
  "DreamMaoMao/yazi.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },

  keys = {
    { "<leader>y", "<cmd>Yazi<CR>", desc = "Toggle Yazi" },
  },
}
