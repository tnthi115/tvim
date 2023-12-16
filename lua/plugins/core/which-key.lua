-- Full spec: https://www.lazyvim.org/plugins/editor#which-keynvim

return {
  "folke/which-key.nvim",
  vscode = true,
  opts = {
    window = {
      border = "single",
    },
  },
  -- opts = function(_, opts)
  --   opts.window = {
  --     border = "single",
  --   }
  --   opts.defaults["<leader>gh"] = nil
  -- end,
}
