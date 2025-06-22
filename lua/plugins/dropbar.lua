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
      -- vim.api.nvim_set_hl(0, "DropBarIconUISeparator", { link = "Comment" })
      -- vim.api.nvim_set_hl(0, "DropBarPreview", { link = "Normal" })
      -- vim.api.nvim_set_hl(0, "DropBarCurrentContext", { link = "Normal" })
      -- vim.api.nvim_set_hl(0, "BufferLineBackground", { link = "Normal" })
      vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" }) -- no background for dropbar
    end,
  },
}
