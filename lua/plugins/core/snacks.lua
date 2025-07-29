-- vim.api.nvim_create_autocmd("VimResized", {
--   callback = function()
--     print "VimResized event triggered"
--     local snacks = package.loaded["plugins.core.snacks"]
--     if
--       snacks
--       and snacks[1]
--       and snacks[1].opts
--       and snacks[1].opts.picker
--       and snacks[1].opts.picker.formatters
--       and snacks[1].opts.picker.formatters.file
--     then
--       snacks[1].opts.picker.formatters.file.truncate = math.floor(vim.api.nvim_win_get_width(0) * 0.35)
--     end
--   end,
-- })
--
return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>s'", "", desc = "Grep with preset glob" },
      {
        "<leader>gC",
        function()
          Snacks.picker.git_branches()
        end,
        desc = "Git Branches",
      },
      {
        "<leader>s'm",
        function()
          Snacks.picker.grep { glob = { "!*lts*", "!*render*", "!*template*" } }
        end,
        desc = "Grep glob !*lts* !*render* !*template*",
      },
      {
        "<leader>s'o",
        function()
          Snacks.picker.grep { glob = { "!*pbgo*", "!*pbswagger*" } }
        end,
        desc = "Grep glob !*pbgo* !*pbswagger*",
      },
      {
        "<leader>fz",
        function()
          Snacks.picker.zoxide()
        end,
        desc = "Zoxide",
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
        formatters = {
          file = {
            truncate = math.floor(vim.api.nvim_win_get_width(0) * 0.35),
          },
        },
        sources = {
          files = { hidden = true },
          grep = { hidden = true, layout = { preset = "ivy" } },
          explorer = { hidden = true },
          git_branches = { layout = { preset = "vertical" } },
          git_diff = { layout = { preset = "default" } },
          git_log = { layout = { preset = "default" } },
          git_log_file = { layout = { preset = "default" } },
          git_log_line = { layout = { preset = "default" } },
          git_stash = { layout = { preset = "default" } },
          git_status = { layout = { preset = "default" } },
        },
        layout = {
          preset = "ivy", -- "default" | "bottom" | "dropdown" | "ivy" | "ivy_split" | "left" | "right" | "select" | "sidebar" | "telescope" | "top" | "vertical" | "vscode"
        },
        -- layouts = {
        --   default = {
        --     layout = {
        --       width = 0.9,
        --       height = 0.9,
        --     },
        --   },
        --   ivy = {
        --     layout = {
        --       height = 0.5,
        --     },
        --   },
        -- },
        previewers = {
          git = {
            native = true,
            layout = "default",
          },
          diff = {
            builtin = false,
            cmd = { "delta" },
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
      -- styles = {
      --   lazygit = {
      --     height = 0,
      --     width = 0,
      --   },
      -- },
      lazygit = {
        -- don't automatically configure lazygit to use the current colorscheme
        -- and integrate edit with the current neovim instance
        configure = false,
        -- win = {
        --   -- See https://github.com/folke/snacks.nvim/blob/main/docs/styles.md
        --   style = "lazygit",
        -- },
      },
    },
  },
}
