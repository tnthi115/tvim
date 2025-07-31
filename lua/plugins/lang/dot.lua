if vim.g.vscode then
  return {}
end

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "bash-language-server" })
    end,
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       bashls = {},
  --     },
  --   },
  -- },
}
