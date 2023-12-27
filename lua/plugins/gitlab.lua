-- https://github.com/harrisoncramer/gitlab.nvim
-- gitlab integration

return {
  {
    "harrisoncramer/gitlab.nvim",
    event = "LazyFile",
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
    config = function()
      require("gitlab").setup {
        port = nil, -- The port of the Go server, which runs in the background, if omitted or `nil` the port will be chosen automatically
        log_path = vim.fn.stdpath "cache" .. "/gitlab.nvim.log", -- Log path for the Go server
        config_path = nil, -- Custom path for `.gitlab.nvim` file, please read the "Connecting to Gitlab" section
        debug = { go_request = false, go_response = false }, -- Which values to log
        attachment_dir = nil, -- The local directory for files (see the "summary" section)
        popup = { -- The popup for comment creation, editing, and replying
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
          toggle_resolved = "x", -- Toggles the resolved status of the whole discussion
          position = "bottom", -- "top", "right", "bottom" or "left"
          open_in_browser = "b", -- Jump to the URL of the current note/discussion
          size = "20%", -- Size of split
          relative = "editor", -- Position of tree split relative to "editor" or "window"
          resolved = "✓", -- Symbol to show next to resolved discussions
          -- unresolved = "✖", -- Symbol to show next to unresolved discussions
          unresolved = "-", -- Symbol to show next to unresolved discussions
          tree_type = "simple", -- Type of discussion tree - "simple" means just list of discussions, "by_file_name" means file tree with discussions under file
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
            "branch",
            "pipeline",
          },
        },
        discussion_sign_and_diagnostic = {
          skip_resolved_discussion = false,
          skip_old_revision_discussion = false,
        },
        discussion_sign = {
          -- See :h sign_define for details about sign configuration.
          enabled = true,
          text = "💬",
          linehl = nil,
          texthl = nil,
          culhl = nil,
          numhl = nil,
          priority = 20, -- Priority of sign, the lower the number the higher the priority
          helper_signs = {
            -- For multiline comments the helper signs are used to indicate the whole context
            -- Priority of helper signs is lower than the main sign (-1).
            enabled = true,
            start = "↑",
            mid = "|",
            ["end"] = "↓",
          },
        },
        discussion_diagnostic = {
          -- If you want to customize diagnostics for discussions you can make special config
          -- for namespace `gitlab_discussion`. See :h vim.diagnostic.config
          enabled = true,
          severity = vim.diagnostic.severity.INFO,
          code = nil, -- see :h diagnostic-structure
          display_opts = {}, -- see opts in vim.diagnostic.set
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
        merge = { -- The default behaviors when merging an MR, see "Merging an MR"
          squash = true,
          delete_branch = true,
        },
        create_mr = {
          target = nil, -- Default branch to target when creating an MR
          template_file = nil, -- Default MR template in .gitlab/merge_request_templates
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
      }

      local which_key_ok, which_key = pcall(require, "which-key")
      if not which_key_ok then
        return
      end

      local opts = {
        mode = { "n", "v" }, -- NORMAL and VISUAL mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
      }

      local mappings = {
        m = {
          name = "+gitlab",
          S = { "<cmd>lua require('gitlab').summary()<CR>", "Summary" },
          A = { "<cmd>lua require('gitlab').approve()<CR>", "Approve" },
          R = { "<cmd>lua require('gitlab').revoke()<CR>", "Revoke" },
          m = {
            "<cmd>lua require('gitlab').move_to_discussion_tree_from_diagnostic()<CR>",
            "Move to discussion tree from diagnostic",
          },
          n = { "<cmd>lua require('gitlab').create_note()<CR>", "Create note" },
          d = { "<cmd>lua require('gitlab').toggle_discussions()<CR>", "Toggle discussions" },
          p = { "<cmd>lua require('gitlab').pipeline()<CR>", "Pipeline" },
          o = { "<cmd>lua require('gitlab').open_in_browser()<CR>", "Open in browser" },
          r = {
            name = "Reviewers",
            a = { "<cmd>lua require('gitlab').add_reviewer()<CR>", "Add reviewer" },
            d = { "<cmd>lua require('gitlab').delete_reviewer()<CR>", "Delete reviewer" },
          },
          c = {
            name = "Comment",
            c = { "<cmd>lua require('gitlab').create_comment()<CR>", "Create comment" },
            m = { "<cmd>lua require('gitlab').create_multiline_comment()<CR>", "Create multiline comment" },
            s = { "<cmd>lua require('gitlab').create_comment_suggestion()<CR>", "Create comment suggestion" },
          },
          a = {
            name = "Assignee",
            a = { "<cmd>lua require('gitlab').add_assignee()<CR>", "Add assignee" },
            d = { "<cmd>lua require('gitlab').delete_assignee()<CR>", "Delete assignee" },
          },
          s = { "<cmd>lua require('gitlab').review()<CR>", "Start review" },
          q = { "<cmd>DiffviewClose<CR>", "Quit review (Diffview)" },
          M = {
            name = "+MR",
            m = { "<cmd>lua require('gitlab').merge()<CR>", "Merge MR" },
            c = { "<cmd>lua require('gitlab').create_mr()", "Create MR" },
          },
        },
      }

      which_key.register(mappings, opts)
    end,
    -- stylua: ignore
    -- keys = {
    --   { "<leader>gLrr", "<cmd>lua require('gitlab').review()<CR>", desc = "Review" },
    --   { "<leader>gLra", "<cmd>lua require('gitlab').add_reviewer()<CR>", desc = "Add reviewer" },
    --   { "<leader>gLrd", "<cmd>lua require('gitlab').delete_reviewer()<CR>", desc = "Delete reviewer" },
    --   { "<leader>gLs", "<cmd>lua require('gitlab').summary()<CR>", desc = "Summary" },
    --   { "<leader>gLA", "<cmd>lua require('gitlab').approve()<CR>", desc = "Approve" },
    --   { "<leader>gLR", "<cmd>lua require('gitlab').revoke()<CR>", desc = "Revoke" },
    --   { "<leader>gLcc", "<cmd>lua require('gitlab').create_comment()<CR>", desc = "Create comment" },
    --   { "<leader>gLcm", "<cmd>lua require('gitlab').create_multiline_comment()<CR>", desc = "Create multiline comment" },
    --   { "<leader>gLcs", "<cmd>lua require('gitlab').create_comment_suggestion()<CR>", desc = "Create comment suggestion" },
    --   { "<leader>gLm", "<cmd>lua require('gitlab').move_to_discussion_tree_from_diagnostic()<CR>", desc = "Move to discussion tree from diagnostic" },
    --   { "<leader>gLn", "<cmd>lua require('gitlab').create_note()<CR>", desc = "Create note" },
    --   { "<leader>gLd", "<cmd>lua require('gitlab').toggle_discussions()<CR>", desc = "Toggle discussions" },
    --   { "<leader>gLaa", "<cmd>lua require('gitlab').add_assignee()<CR>", desc = "Add assignee" },
    --   { "<leader>gLad", "<cmd>lua require('gitlab').delete_assignee()<CR>", desc = "Delete assignee" },
    --   { "<leader>gLp", "<cmd>lua require('gitlab').pipeline()<CR>", desc = "Pipeline" },
    --   { "<leader>gLo", "<cmd>lua require('gitlab').open_in_browser()<CR>", desc = "Open in browser" },
    -- },
  },

  -- https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim
  -- gitlab duo code suggestions
  -- for some reason I get a warning when there are other language servers active (e.g. doesn't work when pyright is active):
  --   warning: multiple different client offset_encodings detected for buffer, this is not supported yet
  -- but it still works I guess?
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
