-- https://github.com/harrisoncramer/gitlab.nvim
-- gitlab integration

return {
  {
    "harrisoncramer/gitlab.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
      "nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
      {
        "folke/which-key.nvim",
        opts = function(_, opts)
          local wk = require "which-key"
          wk.add { "<leader>m", group = "gitlab" }
          wk.add { "<leader>mr", group = "reviewers" }
          wk.add { "<leader>mc", group = "comment" }
          wk.add { "<leader>ma", group = "assignee" }
          wk.add { "<leader>ml", group = "labels" }
        end,
      },
    },
    build = function()
      require("gitlab.server").build(true)
    end, -- Builds the Go binary
    -- stylua: ignore
    keys = {
      { "<leader>ms", "<cmd>lua require('gitlab').review()<CR>", desc = "Start Gitlab review" },
      { "<leader>mS", "<cmd>lua require('gitlab').summary()<CR>", desc = "Summary" },
      { "<leader>mA", "<cmd>lua require('gitlab').approve()<CR>", desc = "Approve MR" },
      { "<leader>mR", "<cmd>lua require('gitlab').revoke()<CR>", desc = "Revoke approval" },
      { "<leader>mc", "<cmd>lua require('gitlab').create_comment()<CR>", desc = "Create comment" },
      { "<leader>mc", "<cmd>lua require('gitlab').create_multiline_comment()<CR>", desc = "Create multiline comment", mode = "v" },
      { "<leader>mC", "<cmd>lua require('gitlab').create_comment_suggestion()<CR>", desc = "Create comment suggestion", mode = "v" },
      { "<leader>mm", "<cmd>lua require('gitlab').move_to_discussion_tree_from_diagnostic()<CR>", desc = "Move to discussion tree from diagnostic" },
      { "<leader>mn", "<cmd>lua require('gitlab').create_note()<CR>", desc = "Create MR note" },
      { "<leader>md", "<cmd>lua require('gitlab').toggle_discussions()<CR>", desc = "Toggle MR discussions" },
      { "<leader>maa", "<cmd>lua require('gitlab').add_assignee()<CR>", desc = "Add MR assignee" },
      { "<leader>mad", "<cmd>lua require('gitlab').delete_assignee()<CR>", desc = "Delete MR assignee" },
      { "<leader>mla", "<cmd>lua require('gitlab').add_label()<CR>", desc = "Add MR label" },
      { "<leader>mld", "<cmd>lua require('gitlab').delete_label()<CR>", desc = "Delete MR label" },
      { "<leader>mra", "<cmd>lua require('gitlab').add_reviewer()<CR>", desc = "Add MR reviewer" },
      { "<leader>mrd", "<cmd>lua require('gitlab').delete_reviewer()<CR>", desc = "Delete MR reviewer" },
      { "<leader>mp", "<cmd>lua require('gitlab').pipeline()<CR>", desc = "Show MR pipeline status" },
      { "<leader>mo", "<cmd>lua require('gitlab').open_in_browser()<CR>", desc = "Open MR in browser" },
      { "<leader>mM", "<cmd>lua require('gitlab').merge()<CR>", desc = "Merge MR" },
      { "<leader>mu", "<cmd>lua require('gitlab').copy_mr_url()<CR>", desc = "Copy MR url" },
      { "<leader>mb", "<cmd>lua require('gitlab').choose_merge_request()<CR>", desc = "Choose MR for Review" },
      { "<leader>mO", "<cmd>lua require('gitlab').create_mr()<CR>", desc = "Create MR" },
      { "<leader>mP", "<cmd>lua require('gitlab').publish_all_drafts()<CR>", desc = "Publish all MR comment drafts" },
      { "<leader>mD", "<cmd>lua require('gitlab').toggle_draft_mode()<CR>", desc = "Toggle MR comment draft mode" },
      { "<leader>mq", "<cmd>DiffviewClose<CR>", desc = "Quit Review (Diffview)" },
    },
    opts = {
      reviewer_settings = {
        diffview = {
          imply_local = true, -- If true, will attempt to use --imply_local option when calling |:DiffviewOpen|
        },
      },
      keymaps = {
        global = {
          disable_all = true,
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

  -- https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim
  -- gitlab duo code suggestions
  -- for some reason I get a warning when there are other language servers active (e.g. doesn't work when pyright is active):
  --   warning: multiple different client offset_encodings detected for buffer, this is not supported yet
  -- but it still works I guess?
  -- this is now a paid feature as part of Duo Pro :(
  -- {
  --   "git@gitlab.com:gitlab-org/editor-extensions/gitlab.vim.git",
  --   enabled = false,
  --   event = { "BufReadPre", "BufNewFile" }, -- Activate when a file is created/opened
  --   -- event = { "LspAttach" }, -- Doesn't work. Needs to be loaded earlier...
  --   -- event = { "LazyFile" },
  --   ft = { "go", "python" }, -- Activate when a supported filetype is open. For supported languages, see https://docs.gitlab.com/ee/user/project/repository/code_suggestions/index.html#supported-languages
  --   cond = function()
  --     -- Only activate is token is present in environment variable (remove to use interactive workflow)
  --     -- I have this shell env var set for gitlab.nvim already, so I can reuse the token here.
  --     return vim.env.GITLAB_TOKEN ~= nil and vim.env.GITLAB_TOKEN ~= ""
  --   end,
  --   -- opts = {
  --   --   statusline = {
  --   --     enabled = true, -- Hook into the builtin statusline to indicate the status of the GitLab Duo Code Suggestions integration
  --   --   },
  --   -- },
  --   config = function()
  --     require("gitlab").setup()
  --
  --     -- TODO: Make this work. It currently disables/overrides nvim-notify.
  --
  --     -- local notify = vim.notify
  --     -- vim.notify = function(msg, ...)
  --     --   if msg:match "warning: multiple different client offset_encodings" then
  --     --     return
  --     --   end
  --     --
  --     --   local nvim_notify_loaded, nvim_notify = pcall(require, "notify")
  --     --   if not nvim_notify_loaded then
  --     --     notify(msg, ...)
  --     --   else
  --     --     nvim_notify(msg, ...)
  --     --   end
  --     -- end
  --     -- local banned_messages = { "warning: multiple different client offset_encodings" }
  --     --
  --     -- vim.notify = function(msg, ...)
  --     --   for _, banned in ipairs(banned_messages) do
  --     --     if msg == banned then
  --     --       return
  --     --     end
  --     --   end
  --     --   require "notify"(msg, ...)
  --     -- end
  --   end,
  -- },
}
