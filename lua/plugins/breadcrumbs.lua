-- https://github.com/LunarVim/breadcrumbs.nvim

return {
  {
    "LunarVim/breadcrumbs.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
      opts = {
        lsp = {
          auto_attach = true,
        },
      },
    },
    event = "LazyFile",
    -- config = function()
    --   require("breadcrumbs").setup()
    -- end,
    config = true,
    -- opts = {},
  },
}
