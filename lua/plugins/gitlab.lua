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
          wk.add { "<leader>mM", group = "mr" }
          wk.add { "<leader>ml", group = "labels" }
        end,
      },
    },
    build = function()
      require("gitlab.server").build(true)
    end, -- Builds the Go binary
    -- stylua: ignore
    keys = {
      { "<leader>ms", "<cmd>lua require('gitlab').review()<CR>", desc = "Start Review" },
      { "<leader>mS", "<cmd>lua require('gitlab').summary()<CR>", desc = "Summary" },
      { "<leader>mA", "<cmd>lua require('gitlab').approve()<CR>", desc = "Approve" },
      { "<leader>mR", "<cmd>lua require('gitlab').revoke()<CR>", desc = "Revoke" },
      { "<leader>mcc", "<cmd>lua require('gitlab').create_comment()<CR>", desc = "Create comment" },
      { "<leader>mcm", "<cmd>lua require('gitlab').create_multiline_comment()<CR>", desc = "Create multiline comment" },
      { "<leader>mcs", "<cmd>lua require('gitlab').create_comment_suggestion()<CR>", desc = "Create comment suggestion" },
      { "<leader>mm", "<cmd>lua require('gitlab').move_to_discussion_tree_from_diagnostic()<CR>", desc = "Move to discussion tree from diagnostic" },
      { "<leader>mn", "<cmd>lua require('gitlab').create_note()<CR>", desc = "Create note" },
      { "<leader>md", "<cmd>lua require('gitlab').toggle_discussions()<CR>", desc = "Toggle discussions" },
      { "<leader>maa", "<cmd>lua require('gitlab').add_assignee()<CR>", desc = "Add assignee" },
      { "<leader>mad", "<cmd>lua require('gitlab').delete_assignee()<CR>", desc = "Delete assignee" },
      { "<leader>mla", "<cmd>lua require('gitlab').add_label()<CR>", desc = "Add label" },
      { "<leader>mld", "<cmd>lua require('gitlab').delete_label()<CR>", desc = "Delete label" },
      { "<leader>mra", "<cmd>lua require('gitlab').add_reviewer()<CR>", desc = "Add reviewer" },
      { "<leader>mrd", "<cmd>lua require('gitlab').delete_reviewer()<CR>", desc = "Delete reviewer" },
      { "<leader>mp", "<cmd>lua require('gitlab').pipeline()<CR>", desc = "Pipeline" },
      { "<leader>mo", "<cmd>lua require('gitlab').open_in_browser()<CR>", desc = "Open in browser" },
      { "<leader>mMm", "<cmd>lua require('gitlab').merge()<CR>", desc = "Merge MR" },
      { "<leader>mMc", "<cmd>lua require('gitlab').create_mr()<CR>", desc = "Create MR" },
      { "<leader>mq", "<cmd>DiffviewClose<CR>", desc = "Quit Review (Diffview)" },
    },
    opts = {
      port = nil, -- The port of the Go server, which runs in the background, if omitted or `nil` the port will be chosen automatically
      log_path = vim.fn.stdpath "cache" .. "/gitlab.nvim.log", -- Log path for the Go server
      config_path = nil, -- Custom path for `.gitlab.nvim` file, please read the "Connecting to Gitlab" section
      debug = { go_request = false, go_response = false }, -- Which values to log
      attachment_dir = nil, -- The local directory for files (see the "summary" section)
      reviewer_settings = {
        diffview = {
          imply_local = true, -- If true, will attempt to use --imply_local option when calling |:DiffviewOpen|
        },
      },
      help = "g?", -- Opens a help popup for local keymaps when a relevant view is focused (popup, discussion panel, etc)
      popup = { -- The popup for comment creation, editing, and replying
        keymaps = {
          next_field = "<Tab>", -- Cycle to the next field. Accepts count.
          prev_field = "<S-Tab>", -- Cycle to the previous field. Accepts count.
        },
        exit = "<Esc>",
        perform_action = "<CR>", -- Once in normal mode, does action (like saving comment or editing description, etc)
        perform_linewise_action = "C-<CR>", -- Once in normal mode, does the linewise action (see logs for this job, etc)
        width = "40%",
        height = "60%",
        border = "rounded", -- One of "rounded", "single", "double", "solid"
        opacity = 1.0, -- From 0.0 (fully transparent) to 1.0 (fully opaque)
        comment = nil, -- Individual popup overrides, e.g. { width = "60%", height = "80%", border = "single", opacity = 0.85 },
        edit = nil,
        note = nil,
        pipeline = nil,
        reply = nil,
        squash_message = nil,
      },
      discussion_tree = { -- The discussion tree that holds all comments
        auto_open = true, -- Automatically open when the reviewer is opened
        -- switch_view = "T", -- Toggles between the notes and discussions views
        switch_view = "<Tab>", -- Toggles between the notes and discussions views
        default_view = "notes", -- Show "discussions" or "notes" by default
        blacklist = {}, -- List of usernames to remove from tree (bots, CI, etc)
        jump_to_file = "o", -- Jump to comment location in file
        jump_to_reviewer = "m", -- Jump to the location in the reviewer window
        edit_comment = "e", -- Edit comment
        delete_comment = "dd", -- Delete comment
        reply = "r", -- Reply to comment
        -- toggle_node = "t", -- Opens or closes the discussion
        toggle_node = "<CR>", -- Opens or closes the discussion
        add_emoji = "Ea", -- Add an emoji to the note/comment
        delete_emoji = "Ed", -- Remove an emoji from a note/comment
        toggle_all_discussions = "T", -- Open or close separately both resolved and unresolved discussions
        toggle_resolved_discussions = "R", -- Open or close all resolved discussions
        toggle_unresolved_discussions = "U", -- Open or close all unresolved discussions
        keep_current_open = false, -- If true, current discussion stays open even if it should otherwise be closed when toggling
        toggle_resolved = "p", -- Toggles the resolved status of the whole discussion
        position = "bottom", -- "top", "right", "bottom" or "left"
        open_in_browser = "b", -- Jump to the URL of the current note/discussion
        size = "20%", -- Size of split
        relative = "editor", -- Position of tree split relative to "editor" or "window"
        resolved = "✓", -- Symbol to show next to resolved discussions
        -- unresolved = "✖", -- Symbol to show next to unresolved discussions
        unresolved = "-", -- Symbol to show next to unresolved discussions
        tree_type = "simple", -- Type of discussion tree - "simple" means just list of discussions, "by_file_name" means file tree with discussions under file
        toggle_tree_type = "i", -- Toggle type of discussion tree - "simple", or "by_file_name"
        winbar = nil, -- Custom function to return winbar title, should return a string. Provided with WinbarTable (defined in annotations.lua)
        -- If using lualine, please add "gitlab" to disabled file types, otherwise you will not see the winbar.
      },
      info = { -- Show additional fields in the summary pane
        enabled = true,
        horizontal = false, -- Display metadata to the left of the summary rather than underneath
        fields = { -- The fields listed here will be displayed, in whatever order you choose
          "author",
          "created_at",
          "updated_at",
          "merge_status",
          "draft",
          "conflicts",
          "assignees",
          "reviewers",
          "pipeline",
          "branch",
          "target_branch",
          "delete_branch",
          "squash",
          "labels",
        },
      },
      discussion_signs = {
        enabled = true, -- Show diagnostics for gitlab comments in the reviewer
        skip_resolved_discussion = false, -- Show diagnostics for resolved discussions
        severity = vim.diagnostic.severity.INFO, -- ERROR, WARN, INFO, or HINT
        virtual_text = false, -- Whether to show the comment text inline as floating virtual text
        priority = 100, -- Higher will override LSP warnings, etc
        icons = {
          comment = "→|",
          range = " |",
        },
      },
      pipeline = {
        created = "",
        pending = "",
        preparing = "",
        scheduled = "",
        running = "ﰌ",
        canceled = "ﰸ",
        skipped = "ﰸ",
        success = "✓",
        failed = "",
      },
      create_mr = {
        target = nil, -- Default branch to target when creating an MR
        template_file = nil, -- Default MR template in .gitlab/merge_request_templates
        delete_branch = false, -- Whether the source branch will be marked for deletion
        squash = false, -- Whether the commits will be marked for squashing
        title_input = { -- Default settings for MR title input window
          width = 40,
          border = "rounded",
        },
      },
      colors = {
        discussion_tree = {
          username = "Keyword",
          date = "Comment",
          chevron = "DiffviewNonText",
          directory = "Directory",
          directory_icon = "DiffviewFolderSign",
          file_name = "Normal",
        },
      },
    },
  },

  -- https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim
  -- gitlab duo code suggestions
  -- for some reason I get a warning when there are other language servers active (e.g. doesn't work when pyright is active):
  --   warning: multiple different client offset_encodings detected for buffer, this is not supported yet
  -- but it still works I guess?
  -- this is now a paid feature as part of Duo Pro :(
  {
    "git@gitlab.com:gitlab-org/editor-extensions/gitlab.vim.git",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" }, -- Activate when a file is created/opened
    -- event = { "LspAttach" }, -- Doesn't work. Needs to be loaded earlier...
    -- event = { "LazyFile" },
    ft = { "go", "python" }, -- Activate when a supported filetype is open. For supported languages, see https://docs.gitlab.com/ee/user/project/repository/code_suggestions/index.html#supported-languages
    cond = function()
      -- Only activate is token is present in environment variable (remove to use interactive workflow)
      -- I have this shell env var set for gitlab.nvim already, so I can reuse the token here.
      return vim.env.GITLAB_TOKEN ~= nil and vim.env.GITLAB_TOKEN ~= ""
    end,
    -- opts = {
    --   statusline = {
    --     enabled = true, -- Hook into the builtin statusline to indicate the status of the GitLab Duo Code Suggestions integration
    --   },
    -- },
    config = function()
      require("gitlab").setup()

      -- TODO: Make this work. It currently disables/overrides nvim-notify.

      -- local notify = vim.notify
      -- vim.notify = function(msg, ...)
      --   if msg:match "warning: multiple different client offset_encodings" then
      --     return
      --   end
      --
      --   local nvim_notify_loaded, nvim_notify = pcall(require, "notify")
      --   if not nvim_notify_loaded then
      --     notify(msg, ...)
      --   else
      --     nvim_notify(msg, ...)
      --   end
      -- end
      -- local banned_messages = { "warning: multiple different client offset_encodings" }
      --
      -- vim.notify = function(msg, ...)
      --   for _, banned in ipairs(banned_messages) do
      --     if msg == banned then
      --       return
      --     end
      --   end
      --   require "notify"(msg, ...)
      -- end
    end,
  },
}
