-- Full spec: https://www.lazyvim.org/plugins/editor#telescopenvim-optional

local actions = require "telescope.actions"

return {
  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fP",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root, hidden = true}) end,
        desc = "Find Plugin File",
      },
      -- {
      --   "<leader>gB",
      --   -- function()
      --   --   require("telescope.builtin").git_branches()
      --   -- end,
      --   "<cmd>Telescope git_branches<CR>",
      --   desc = "Checkout Branch",
      -- },
      -- { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Checkout Commit" },
      -- { "<leader>go", "<cmd>Telescope git_status<CR>", desc = "Status" },
      -- remove git status keybind
      -- { "<leader>gs", false },
      -- remove sort_lastused=true from Telescope buffers keybinds
      -- { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      {
        "<leader>,",
        "<cmd>Telescope buffers sort_mru=true<cr>",
        desc = "Switch Buffer",
      },
      { "<leader>fb", "<cmd>Telescope buffers sort_mru=true<cr>", desc = "Buffers" },
      -- { "<leader><space>", LazyVim.pick "auto", desc = "Find Files (Root Dir)" },
      { "<leader><space>", "<cmd>Telescope git_files<CR>", desc = "Find Files (git-files)" },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "flex",
        layout_config = {
          flex = {
            flip_columns = 130,
          },
          -- horizontal = {
          --   preview_width = 0.5,
          --   -- preview_width = { 0.55, min = 20 },
          -- },
        },
        -- layout_config = { prompt_position = "top" },
        -- sorting_strategy = "ascending",
        -- winblend = 0,
        -- file_ignore_patterns = {
        --   ".git/",
        -- },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        git_files = {
          hidden = true,
        },
        live_grep = {
          additional_args = { "--hidden" },
        },
        grep_string = {
          additional_args = { "--hidden" },
        },
        git_branches = {
          theme = "dropdown",
        },
        git_commits = {
          theme = "dropdown",
        },
      },
    },
  },
  -- overwriting lazyvim.plugins.extras.util.project
  {
    "ahmedkhalf/project.nvim",
    opts = {
      -- Manual mode doesn't automatically change your root directory, so you have
      -- the option to manually do so using `:ProjectRoot` command.
      manual_mode = false,
      -- Methods of detecting the root directory. **"lsp"** uses the native neovim
      -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
      -- order matters: if one is not detected, the other is used as fallback. You
      -- can also delete or rearangne the detection methods.
      detection_methods = { "pattern", "lsp" },
      -- detection_methods = { "pattern" },
      show_hidden = true,
    },
  },
}
