return {
  {
    "LunarVim/breadcrumbs.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    event = "LazyFile",
    config = function()
      require("breadcrumbs").setup()
    end,
  },
}
