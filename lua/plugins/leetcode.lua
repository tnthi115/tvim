--  https://github.com/kawre/leetcode.nvim

local leet_arg = "leetcode.nvim"

return {
  "kawre/leetcode.nvim",
  lazy = leet_arg ~= vim.fn.argv()[1],
  event = "BufEnter leetcode.nvim",
  cmd = "Leet",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim", -- required by telescope
    "MunifTanjim/nui.nvim",

    -- optional
    "nvim-treesitter/nvim-treesitter",
    "rcarriga/nvim-notify",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local which_key_ok, which_key = pcall(require, "which-key")
    if which_key_ok then
      local opts = {
        mode = "n", -- NORMAL
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
      }

      local mappings = {
        L = {
          name = "+leetcode",
          m = { "<cmd>Leet menu<CR>", "Menu" },
          c = { "<cmd>Leet console<CR>", "Console" },
          i = { "<cmd>Leet info<CR>", "Info" },
          [","] = { "<cmd>Leet tabs<CR>", "Tabs" },
          L = { "<cmd>Leet lang<CR>", "Lang" },
          r = { "<cmd>Leet run<CR>", "Run" },
          t = { "<cmd>Leet test<CR>", "Test" },
          s = { "<cmd>Leet submit<CR>", "Submit" },
          R = { "<cmd>Leet random<CR>", "Random" },
          D = { "<cmd>Leet daily<CR>", "Daily" },
          l = { "<cmd>Leet list<CR>", "List" },
          d = {
            name = "Desc",
            d = { "<cmd>Leet desc toggle<CR>", "Toggle" },
            s = { "<cmd>Leet desc stats<CR>", "Stats" },
          },
          C = {
            name = "Cookie",
            d = { "<cmd>Leet cookie update<CR>", "Update" },
            s = { "<cmd>Leet cookie delete<CR>", "Delete (Sign-out)" },
          },
          u = { "<cmd>Leet cache update<CR>", "Update Cache" },
        },
      }

      which_key.register(mappings, opts)
    end

    require("leetcode").setup {
      ---@type string
      arg = leet_arg,

      ---@type lc.lang
      lang = "golang",

      cn = { -- leetcode.cn
        enabled = false, ---@type boolean
        translator = true, ---@type boolean
        translate_problems = true, ---@type boolean
      },

      ---@type lc.storage
      storage = {
        home = vim.fn.expand "$HOME/leetcode/",
        cache = vim.fn.stdpath "cache" .. "/leetcode",
      },

      ---@type boolean
      logging = true,

      ---@type table<lc.lang, lc.inject>
      injector = {
        ["cpp"] = {
          before = { "#include <bits/stdc++.h>", "using namespace std;" },
          after = "int main() {}",
        },
        ["java"] = {
          before = "import java.util.*;",
        },
        ["golang"] = {
          before = "package leetcode",
        },
      },

      cache = {
        update_interval = 60 * 60 * 24 * 7, ---@type integer 7 days
      },

      console = {
        open_on_runcode = true, ---@type boolean

        dir = "row", ---@type lc.direction

        size = { ---@type lc.size
          width = "90%",
          height = "75%",
        },

        result = {
          size = "60%", ---@type lc.size
        },

        testcase = {
          virt_text = true, ---@type boolean

          size = "40%", ---@type lc.size
        },
      },

      description = {
        position = "left", ---@type lc.position

        width = "40%", ---@type lc.size

        show_stats = true, ---@type boolean
      },

      hooks = {
        ---@type fun()[]
        LeetEnter = {},

        ---@type fun(question: { lang: string })[]
        LeetQuestionNew = {},
      },

      keys = {
        toggle = { "q", "<Esc>" }, ---@type string|string[]
        confirm = { "<CR>" }, ---@type string|string[]

        reset_testcases = "r", ---@type string
        use_testcase = "U", ---@type string
        focus_testcases = "H", ---@type string
        focus_result = "L", ---@type string
      },

      ---@type boolean
      image_support = true, -- setting this to `true` will disable question description wrap
    }
  end,
}
