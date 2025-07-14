-- https://github.com/miroshQa/debugmaster.nvim

return {
  { "rcarriga/nvim-dap-ui", enabled = false },
  {
    "miroshQa/debugmaster.nvim",
    -- event = "LazyFile",
    -- osv is needed if you want to debug neovim lua code. Also can be used
    -- as a way to quickly test-drive the plugin without configuring debug adapters
    dependencies = { "mfussenegger/nvim-dap", "jbyuki/one-small-step-for-vimkind" },
    keys = {
      {
        "<leader>du",
        function()
          require("debugmaster").mode.toggle()
        end,
        desc = "Toggle debug mode",
      },
    },
    config = function()
      local dm = require "debugmaster"
      -- make sure you don't have any other keymaps that starts with "<leader>d" to avoid delay
      -- Alternative keybindings to "<leader>d" could be: "<leader>m", "<leader>;"
      -- vim.keymap.set({ "n", "v" }, "<leader>D", dm.mode.toggle, { nowait = true })
      -- If you want to disable debug mode in addition to leader+d using the Escape key:
      -- vim.keymap.set("n", "<Esc>", dm.mode.disable)
      -- This might be unwanted if you already use Esc for ":noh"
      -- vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

      -- vim.keymap.set({ "n", "v" }, "?", dm.keys.get("H").action)
      -- TODO: remap "H" to "?"
      -- dm.keys.add {
      --   key = "?",
      --   action = dm.keys.get("H").action,
      --   desc = dm.keys.get("H").desc,
      --   nowait = dm.keys.get("H").nowait,
      --   group = dm.keys.get("H").group,
      --   mode = dm.keys.get("H").modes,
      -- }
      -- dm.keys.add {
      --   key = "H",
      --   action = function() end,
      -- }

      dm.plugins.osv_integration.enabled = true -- needed if you want to debug neovim lua code
      -- local dap = require "dap"
      -- Configure your debug adapters here
      -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
    end,
  },
  -- FIXME: doesn't work
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   priority = 0,
  --   opts = function(_, opts)
  --     local dmode_enabled = false
  --     vim.api.nvim_create_autocmd("User", {
  --       pattern = "DebugModeChanged",
  --       callback = function(args)
  --         dmode_enabled = args.data.enabled
  --       end,
  --     })
  --
  --     -- Modify the first item in opts.sections.lualine_a
  --     opts.sections.lualine_a[1] = {
  --       -- mode
  --       function()
  --         -- return " " .. "󰀘" .. " "
  --         -- return " " .. "" .. " "
  --         return " " .. "💤" .. " "
  --         -- return " " .. "󰒲" .. " "
  --       end,
  --       padding = { left = 0, right = 0 },
  --       color = function(tb)
  --         return dmode_enabled and "dCursor" or tb
  --       end,
  --       cond = nil,
  --     }
  --   end,
  -- },
}
