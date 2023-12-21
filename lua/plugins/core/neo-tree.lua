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
      follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every time
        --               -- the current file is changed while the tree is open.
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      -- "open_default" -- netrw disabled, opening a directory opens neo-tree
      --                -- in whatever position is specified in window.position
      -- "open_current" -- netrw disabled, opening a directory opens within the
      --                -- window like netrw would, regardless of window.position
      -- "disabled"     -- netrw left alone, neo-tree does not handle opening dirs
      hijack_netrw_behavior = "open_current",
    },
  },
}
