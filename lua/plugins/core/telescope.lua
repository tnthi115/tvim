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
      {
        "<leader>gb",
        -- function()
        --   require("telescope.builtin").git_branches()
        -- end,
        "<cmd>Telescope git_branches",
        desc = "Checkout branch",
      },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Checkout commit" },
      { "<leader>go", "<cmd>Telescope git_status<CR>", desc = "Status" },
    },
    -- change some options
    opts = {
      defaults = {
        -- layout_strategy = "horizontal",
        --   layout_config = { prompt_position = "top" },
        --   sorting_strategy = "ascending",
        --   winblend = 0,
        -- file_ignore_patterns = {
        --   ".git",
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
      show_hidden = true,
    },
  },
}
