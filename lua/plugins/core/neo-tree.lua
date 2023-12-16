-- Full spec: https://www.lazyvim.org/plugins/editor#neo-treenvim

return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      width = 35,
      mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
      },
    },
    filesystem = {
      filtered_items = {
        visible = true,
      },
    },
  },
}
