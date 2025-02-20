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
        Snacks.picker.grep { glob = { "!*lts*", "!*render*", "!*template*" } }
      end,
      desc = "Grep in m",
    },
    {
      "<leader>s/o",
      function()
        Snacks.picker.grep { glob = { "!*pbgo*", "!*pbswagger*" } }
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
      layout = {
        preset = "default",
      },
      previewers = {
        git = {
          native = true,
        },
      },
      -- actions = require("trouble.sources.snacks").actions,
      win = {
        input = {
          keys = {
            ["<c-t>"] = {
              "trouble_open",
              mode = { "n", "i" },
            },
          },
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
    styles = {
      lazygit = {
        height = 0,
        width = 0,
      },
    },
    lazygit = {
      -- don't automatically configure lazygit to use the current colorscheme
      -- and integrate edit with the current neovim instance
      configure = false,
      win = {
        -- See https://github.com/folke/snacks.nvim/blob/main/docs/styles.md
        style = "lazygit",
      },
    },
  },
}
