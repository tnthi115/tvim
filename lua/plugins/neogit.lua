-- https://github.com/NeogitOrg/neogit

return {
  "NeogitOrg/neogit",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    -- Only one of these is needed, not both.
    -- "nvim-telescope/telescope.nvim", -- optional
    "ibhagwan/fzf-lua", -- optional
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gn", "<cmd>Neogit<CR>", desc = "Neogit" },
  },
  opts = {
    -- Disables changing the buffer highlights based on where the cursor is.
    disable_context_highlighting = true,
    -- Change the default way of opening neogit. Can be one of the following:
    -- tab, replace, floaing (experimental), split, split_above, vsplit, auto
    -- (vsplit if window would have 80 cols, otherwise split)
    kind = "tab",
    -- graph_style = "unicode",
    status = {
      recent_commit_count = 10,
    },
    sections = {
      recent = {
        folded = false,
      },
    },
    mappings = {
      -- popup = {
      --   ["x"] = "DiffPopup",
      -- },
      status = {
        ["a"] = "StageAll",
        -- ["d"] = "Discard",
      },
    },
  },
}
