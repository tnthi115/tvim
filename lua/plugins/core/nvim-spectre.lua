-- Full spec: https://www.lazyvim.org/plugins/editor#nvim-spectre

return {
  "nvim-pack/nvim-spectre",
  opts = {
    default = {
      find = {
        cmd = "rg",
        options = { "ignore-case", "hidden" },
      },
    },
  },
}
