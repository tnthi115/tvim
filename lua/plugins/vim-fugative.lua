-- https://github.com/tpope/vim-fugitive

return {
  {
    "tpope/vim-fugitive",
    event = "LazyFile",
    keys = {
      { "<leader>gF", "<cmd>Git<CR>", desc = "Fugitive" },
    },
  },
}
