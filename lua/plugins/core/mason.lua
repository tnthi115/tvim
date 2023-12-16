-- Full spec: https://www.lazyvim.org/extras/formatting/prettier#masonnvim

return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "stylua",
      "shfmt",
      -- TODO: add more
    },
  },
}
