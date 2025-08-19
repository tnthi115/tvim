-- https://github.com/harrisoncramer/gitlab.nvim
-- gitlab MR integration

return {
  {
    name = "gitlab-mrs",
    "harrisoncramer/gitlab.nvim",
    enabled = true,
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
      "nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
      -- {
      --   "folke/which-key.nvim",
      --   opts = function(_, opts)
      --     local wk = require "which-key"
      --     wk.add { "<leader>m", group = "gitlab" }
      --     wk.add { "<leader>mr", group = "reviewers" }
      --     wk.add { "<leader>mc", group = "comment" }
      --     wk.add { "<leader>ma", group = "assignee" }
      --     wk.add { "<leader>ml", group = "labels" }
      --   end,
      -- },
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
      -- { "<leader>ms", "<cmd>lua require('gitlab').review()<CR>", desc = "Start Gitlab review" },
      -- { "<leader>mS", "<cmd>lua require('gitlab').summary()<CR>", desc = "Summary" },
      -- { "<leader>mA", "<cmd>lua require('gitlab').approve()<CR>", desc = "Approve MR" },
      -- { "<leader>mR", "<cmd>lua require('gitlab').revoke()<CR>", desc = "Revoke approval" },
      -- { "<leader>mc", "<cmd>lua require('gitlab').create_comment()<CR>", desc = "Create comment" },
      -- { "<leader>mc", "<cmd>lua require('gitlab').create_multiline_comment()<CR>", desc = "Create multiline comment", mode = "v" },
      -- { "<leader>mC", "<cmd>lua require('gitlab').create_comment_suggestion()<CR>", desc = "Create comment suggestion", mode = "v" },
      -- { "<leader>mm", "<cmd>lua require('gitlab').move_to_discussion_tree_from_diagnostic()<CR>", desc = "Move to discussion tree from diagnostic" },
      -- { "<leader>mn", "<cmd>lua require('gitlab').create_note()<CR>", desc = "Create MR note" },
      -- { "<leader>md", "<cmd>lua require('gitlab').toggle_discussions()<CR>", desc = "Toggle MR discussions" },
      -- { "<leader>maa", "<cmd>lua require('gitlab').add_assignee()<CR>", desc = "Add MR assignee" },
      -- { "<leader>mad", "<cmd>lua require('gitlab').delete_assignee()<CR>", desc = "Delete MR assignee" },
      -- { "<leader>mla", "<cmd>lua require('gitlab').add_label()<CR>", desc = "Add MR label" },
      -- { "<leader>mld", "<cmd>lua require('gitlab').delete_label()<CR>", desc = "Delete MR label" },
      -- { "<leader>mra", "<cmd>lua require('gitlab').add_reviewer()<CR>", desc = "Add MR reviewer" },
      -- { "<leader>mrd", "<cmd>lua require('gitlab').delete_reviewer()<CR>", desc = "Delete MR reviewer" },
      -- { "<leader>mp", "<cmd>lua require('gitlab').pipeline()<CR>", desc = "Show MR pipeline status" },
      -- { "<leader>mo", "<cmd>lua require('gitlab').open_in_browser()<CR>", desc = "Open MR in browser" },
      -- { "<leader>mM", "<cmd>lua require('gitlab').merge()<CR>", desc = "Merge MR" },
      -- { "<leader>mu", "<cmd>lua require('gitlab').copy_mr_url()<CR>", desc = "Copy MR url" },
      -- { "<leader>mb", "<cmd>lua require('gitlab').choose_merge_request()<CR>", desc = "Choose MR for Review" },
      -- { "<leader>mO", "<cmd>lua require('gitlab').create_mr()<CR>", desc = "Create MR" },
      -- { "<leader>mP", "<cmd>lua require('gitlab').publish_all_drafts()<CR>", desc = "Publish all MR comment drafts" },
      -- { "<leader>mD", "<cmd>lua require('gitlab').toggle_draft_mode()<CR>", desc = "Toggle MR comment draft mode" },
      -- { "<leader>mq", "<cmd>DiffviewClose<CR>", desc = "Quit Review (Diffview)" },
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
