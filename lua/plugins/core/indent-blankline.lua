-- Full spec: https://www.lazyvim.org/plugins/ui#indent-blanklinenvim

return {
  "lukas-reineke/indent-blankline.nvim",
  optional = true,
  opts = {
    scope = {
      highlight = { "Normal" },
    },
  },
}
