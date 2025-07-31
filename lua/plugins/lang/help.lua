-- https://github.com/OXY2DEV/helpview.nvim

if vim.g.vscode then
  return {}
end

return {
  "OXY2DEV/helpview.nvim",
  ft = "help",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
}
