return {
  {
    "LunarVim/breadcrumbs.nvim",
    event = "LazyFile",
    config = function()
      require("breadcrumbs").setup()
    end,
  },
}
