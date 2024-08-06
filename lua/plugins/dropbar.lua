-- https://github.com/Bekaboo/dropbar.nvim

return {
  {
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    event = "LazyFile",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    opts = function()
      vim.api.nvim_set_hl(0, "DropBarIconUISeparator", { link = "Comment" })
    end,
  },
}
