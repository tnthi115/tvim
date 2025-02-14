return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>gC",
      function()
        Snacks.picker.git_branches()
      end,
      desc = "Git Branches",
    },
    {
      "<leader>s/m",
      function()
        Snacks.picker.grep { glob = "!*lts* !*render* !*template*" }
      end,
      desc = "Grep in m",
    },
    {
      "<leader>s/o",
      function()
        Snacks.picker.grep { glob = "!*pbgo* !*pbswagger*" }
      end,
      desc = "Grep in o",
    },
  },
  opts = {
    indent = {
      indent = {
        -- only_current = true,
        -- hl = "Normal",
      },
      animate = {
        enabled = false,
      },
      scope = {
        hl = "Normal",
      },
      chunk = {
        enabled = false,
      },
    },
    -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
    -- layouts: https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#picker_layouts
    --   run :lua Snacks.picker.picker_layouts(opts?)
    picker = {
      previewers = {
        git = {
          native = true,
        },
      },
    },
    image = {
      markdown = {
        -- enable image viewer for markdown files
        -- if your env doesn't support unicode placeholders, this will be disabled
        enabled = true,
        max_width = 80,
        max_height = 40,
      },
    },
  },
}
