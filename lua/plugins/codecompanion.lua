-- https://github.com/olimorris/codecompanion.nvim?tab=readme-ov-file

return {
  {
    "olimorris/codecompanion.nvim",
    event = "LazyFile",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- Optional
      "stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
      {
        "folke/which-key.nvim",
        opts = function(_, opts)
          local wk = require "which-key"
          wk.add { "<leader>a", group = "ai (CodeCompanion)" }
        end,
      },
    },
    keys = {
      { "<leader>aa", ":CodeCompanion" },
      { "<leader>ac", "<cmd>CodeCompanionChat<CR>", desc = "Open New Chat Buffer" },
      { "<leader>au", "<cmd>CodeCompanionToggle<CR>", desc = "Toggle Chat Buffer" },
      { "<leader>aA", "<cmd>CodeCompanionAdd<CR>", desc = "Add Selection to Chat Buffer", mode = { "n", "x", "v" } },
    },
    opts = {
      strategies = {
        chat = {
          adapter = "ollama",
        },
        inline = {
          adapter = "ollama",
        },
        agent = {
          adapter = "ollama",
        },
      },
    },
  },
}
