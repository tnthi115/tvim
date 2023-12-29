-- Full spec: https://www.lazyvim.org/plugins/editor#neo-treenvim

return {
  "nvim-neo-tree/neo-tree.nvim",
  -- dependencies = {
  --   {
  --     "nvim-tree/nvim-web-devicons",
  --     opts = {
  --       override = {
  --         toml = {
  --           icon = "",
  --           color = "#ffffff",
  --           cterm_color = "231",
  --           name = "Toml",
  --         },
  --       },
  --     },
  --   },
  -- },
  opts = {
    enable_normal_mode_for_inputs = true, -- Enable normal mode for input dialogs.
    default_component_configs = {
      icon = {
        default = "", -- The default "*" is ugly.
        highlight = "Normal",
      },
      git_status = {
        symbols = {
          -- Change type
          added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = "✖", -- this can only be used in the git_status source
          renamed = "󰁕", -- this can only be used in the git_status source
          -- Status type
          untracked = "",
          ignored = "",
          unstaged = "󰄱",
          staged = "",
          conflict = "",
        },
      },
    },
    window = {
      width = 35,
      mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
      },
    },
    filesystem = {
      filtered_items = {
        visible = true, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = true, -- only works on Windows for hidden files/directories
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
