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
    local wk_ok, wk = pcall(require, "which-key")
    if wk_ok then
      wk.add {
        { "<leader>.", group = "leetcode" },
        { "<leader>.m", "<cmd>Leet menu<CR>", desc = "Menu" },
        { "<leader>.c", "<cmd>Leet console<CR>", desc = "Console" },
        { "<leader>.i", "<cmd>Leet info<CR>", desc = "Info" },
        { "<leader>.,", "<cmd>Leet tabs<CR>", desc = "Tabs" },
        { "<leader>.L", "<cmd>Leet lang<CR>", desc = "Lang" },
        { "<leader>.r", "<cmd>Leet run<CR>", desc = "Run" },
        { "<leader>.t", "<cmd>Leet test<CR>", desc = "Test" },
        { "<leader>.s", "<cmd>Leet submit<CR>", desc = "Submit" },
        { "<leader>.R", "<cmd>Leet random<CR>", desc = "Random" },
        { "<leader>.D", "<cmd>Leet daily<CR>", desc = "Daily" },
        { "<leader>.l", "<cmd>Leet list<CR>", desc = "List" },
        { "<leader>.d", group = "desc" },
        { "<leader>.dd", "<cmd>Leet desc toggle<CR>", desc = "Toggle" },
        { "<leader>.ds", "<cmd>Leet desc stats<CR>", desc = "Stats" },
        { "<leader>.C", group = "cookie" },
        { "<leader>.Cd", "<cmd>Leet cookie update<CR>", desc = "Update" },
        { "<leader>.Cs", "<cmd>Leet cookie delete<CR>", desc = "Delete (Sign-out)" },
        { "<leader>.u", "<cmd>Leet cache update<CR>", desc = "Update Cache" },
      }
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
