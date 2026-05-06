-- There are many opencode.nvim projects currently on github: https://github.com/search?q=opencode.nvim&type=repositories

return {
  {
    "NickvanDyke/opencode.nvim",
    version = "*",
    dependencies = {
      {
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = { -- Enhances `select()`
            actions = {
              opencode_send = function(...)
                return require("opencode").snacks_picker_send(...)
              end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      local opencode_cmd = "opencode --port"
      ---@type snacks.terminal.Opts
      local snacks_terminal_opts = {
        auto_close = true,
        win = {
          position = "right",
          enter = false,
          wo = {
            winbar = "",
          },
          bo = {
            filetype = "opencode_terminal",
          },
          on_win = function(win)
            -- Set up keymaps and cleanup for an arbitrary terminal
            require("opencode.terminal").setup(win.win)
          end,
        },
      }
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        server = {
          start = function()
            require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
          end,
          stop = function()
            require("snacks.terminal").get(opencode_cmd, snacks_terminal_opts):close()
          end,
          toggle = function()
            require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
          end,
        },
      }

      -- Required for `opts.events.reload`
      vim.opt.autoread = true
    end,
    keys = {
      { "<leader>o", "", desc = "opencode", mode = { "n", "x" } },
      {
        "<leader>oa",
        function()
          require("opencode").ask("@this: ", { submit = true })
        end,
        desc = "Ask opencode",
        mode = { "n", "x" },
      },
      {
        "<leader>o+",
        function()
          require("opencode").prompt "@this"
        end,
        desc = "Add this",
        mode = { "n", "x" },
      },
      {
        "<leader>oe",
        function()
          require("opencode").prompt("Explain @this and its context", { submit = true })
        end,
        desc = "Explain this",
        mode = { "n", "x" },
      },
      {
        "<leader>os",
        function()
          require("opencode").select()
        end,
        desc = "Select action…",
        mode = { "n", "x" },
      },
      {
        "<leader>ot",
        function()
          require("opencode").toggle()
        end,
        desc = "Toggle terminal",
        mode = { "n", "t" },
      },
      {
        "<leader>on",
        function()
          require("opencode").command "session.new"
        end,
        desc = "New session",
      },
      {
        "<leader>oi",
        function()
          require("opencode").command "session.interrupt"
        end,
        desc = "Interrupt session",
      },
      {
        "<leader>oS",
        function()
          -- Show the server picker to switch active opencode server
          require("opencode").select_server()
        end,
        desc = "Switch server",
      },
      {
        "<S-C-u>",
        function()
          require("opencode").command "session.half.page.up"
        end,
        desc = "Scroll opencode up",
        mode = "n",
      },
      {
        "<S-C-d>",
        function()
          require("opencode").command "session.half.page.down"
        end,
        desc = "Scroll opencode down",
        mode = "n",
      },
    },
  },
}
