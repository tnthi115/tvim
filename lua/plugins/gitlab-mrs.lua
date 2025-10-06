-- https://github.com/harrisoncramer/gitlab.nvim
-- gitlab MR integration

return {
  {
    name = "gitlab-mrs",
    "harrisoncramer/gitlab.nvim",
    enabled = false,
    -- event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
      "nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
    },
    build = function()
      require("gitlab.server").build(true)
    end, -- Builds the Go binary
    -- stylua: ignore
    keys = {
      { "gl", "", desc = "gitlab MRs" },
      { "gla", "", desc = "assignees" },
      { "gll", "", desc = "labels" },
      { "glr", "", desc = "reviewers" },
      -- default keymaps:
      --   https://github.com/harrisoncramer/gitlab.nvim/blob/main/doc/gitlab.nvim.txt?plain=1#L168-L193
      --   https://github.com/harrisoncramer/gitlab.nvim/blob/main/lua/gitlab/state.lua#L70-L94
      -- descriptions and keymap registration:
      --   https://github.com/harrisoncramer/gitlab.nvim/blob/main/lua/gitlab/state.lua#L277-L420
      { "glaa", "<cmd>lua require('gitlab').add_assignee()<cr>", desc = "Add MR assignee" },
      { "glad", "<cmd>lua require('gitlab').delete_assignee()<cr>", desc = "Delete MR assignee" },
      { "glla", "<cmd>lua require('gitlab').add_label()<cr>", desc = "Add MR label" },
      { "glld", "<cmd>lua require('gitlab').delete_label()<cr>", desc = "Delete MR label" },
      { "glra", "<cmd>lua require('gitlab').add_reviewer()<cr>", desc = "Add MR reviewer" },
      { "glrd", "<cmd>lua require('gitlab').delete_reviewer()<cr>", desc = "Delete MR reviewer" },
      { "glA", "<cmd>lua require('gitlab').approve()<cr>", desc = "Approve MR" },
      { "glR", "<cmd>lua require('gitlab').revoke()<cr>", desc = "Revoke approval" },
      { "glM", "<cmd>lua require('gitlab').merge()<cr>", desc = "Merge MR" },
      { "glC", "<cmd>lua require('gitlab').create_mr()<cr>", desc = "Create MR" },
      { "glc", "<cmd>lua require('gitlab').choose_merge_request()<cr>", desc = "Choose MR for review" },
      { "glS", "<cmd>lua require('gitlab').review()<cr>", desc = "Start Gitlab review" },
      { "gls", "<cmd>lua require('gitlab').summary()<cr>", desc = "Show MR summary" },
      { "glu", "<cmd>lua require('gitlab').copy_mr_url()<cr>", desc = "Copy MR url" },
      { "glo", "<cmd>lua require('gitlab').open_in_browser()<cr>", desc = "Open MR in browser" },
      { "gln", "<cmd>lua require('gitlab').create_note()<cr>", desc = "Create MR note" },
      { "glp", "<cmd>lua require('gitlab').pipeline()<cr>", desc = "Show MR pipeline status" },
      { "gld", "<cmd>lua require('gitlab').toggle_discussions()<cr>", desc = "Toggle MR discussions" },
      { "glD", "<cmd>lua require('gitlab').toggle_draft_mode()<cr>", desc = "Toggle MR comment draft mode" },
      { "glP", "<cmd>lua require('gitlab').publish_all_drafts()<cr>", desc = "Publish all MR comment drafts" },
    },
    opts = {
      reviewer_settings = {
        diffview = {
          imply_local = true, -- If true, will attempt to use --imply_local option when calling |:DiffviewOpen|
        },
      },
      keymaps = {
        global = {
          disable_all = false,
        },
        discussion_tree = {
          switch_view = "<Tab>",
          toggle_node = "<CR>",
        },
      },
      discussion_tree = {
        default_view = "notes",
        position = "bottom",
      },
    },
  },
}
