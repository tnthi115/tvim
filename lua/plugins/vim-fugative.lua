-- https://github.com/tpope/vim-fugitive

return {
  {
    "tpope/vim-fugitive",
    -- event = "LazyFile",
    cmd = {
      "Git",
      "G",
      "Gdiffsplit",
      "Gvdiffsplit",
      "Gedit",
      "Gsplit",
      "Gvsplit",
      "Gtabedit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "Glgrep",
      "GMove",
      "GRename",
      "GDelete",
      "GRemove",
      "GBrowse",
    },
    keys = {
      { "<leader>gF", "<cmd>Git<CR>", desc = "Fugitive" },
    },
  },
}
