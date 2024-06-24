-- Full spec: https://www.lazyvim.org/plugins/editor#which-keynvim

return {
  "folke/which-key.nvim",
  vscode = true,
  opts = {
    window = {
      border = "single",
    },
    defaults = {
      ["<leader>l"] = { name = "+lazyvim" },
    },
  },
}
