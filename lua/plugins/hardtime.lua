-- https://github.com/m4xshen/hardtime.nvim
-- https://github.com/m4xshen/hardtime.nvim/issues/5

return {
  "m4xshen/hardtime.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  keys = { { "<leader>uH", "<cmd>Hardtime toggle<CR>", desc = "Toggle Hardtime" } },
  opts = {
    disable_mouse = false,
    disabled_filetypes = {
      "NvimTree",
      "TelescopePrompt",
      "aerial",
      "alpha",
      "checkhealth",
      "dapui-repl",
      "dapui_breakpoints",
      "dapui_console",
      "dapui_scopes",
      "dapui_stacks",
      "dapui_watches",
      "DressingInput",
      "DressingSelect",
      "help",
      "lazy",
      "NeogitStatus",
      "NeogitLogView",
      "mason",
      "neotest-summary",
      "minifiles",
      "neo-tree",
      "neo-tree-popup",
      "netrw",
      "noice",
      "notify",
      "prompt",
      "qf",
      "oil",
      "undotree",
      "gitlab", -- disable for gitlab.nvim discussion window
      "git", -- disable for gitlab.nvim commit log panel
      "leetcode.nvim",
    },
  },
}
