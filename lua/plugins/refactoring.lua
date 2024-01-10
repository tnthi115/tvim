-- https://github.com/ThePrimeagen/refactoring.nvim

return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.defaults["<leader>r"] = { name = "+refactoring" }
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    -- event = "LazyFile",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    cmd = "Refactor",
    -- stylua: ignore
    keys = {
      -- Refactoring Operations
      -- Prompt for a refactor to apply when the remap is triggered.
      ---@diagnostic disable-next-line: missing-parameter
      { mode = {"n", "x"}, "<leader>rr", function() require('refactoring').select_refactor() end, desc = "Select Refactor" },
      { mode = "x", "<leader>re", function() require('refactoring').refactor('Extract Function') end, desc = "Extract Function" },
      { mode = "x", "<leader>rf", function() require('refactoring').refactor('Extract Function To File') end, desc = "Extract Function To File" },
      { mode = "x", "<leader>rv", function() require('refactoring').refactor('Extract Variable') end, desc = "Extract Variable" },
      { mode = "x", "<leader>ri", function() require('refactoring').refactor('Inline Variable') end, desc = "Inline Variable" },
      { mode = "n", "<leader>ri", function() require('refactoring').refactor('Inline Variable') end, desc = "Inline Variable" },
      { mode = "n", "<leader>rb", function() require('refactoring').refactor('Extract Block') end, desc = "Extract Block" },
      { mode = "n", "<leader>rB", function() require('refactoring').refactor('Extract Block To File') end, desc = "Extract Block To File" },
      -- Debug Operations
      ---@diagnostic disable-next-line: missing-fields
      { mode = "n", "<leader>rP", function() require('refactoring').debug.printf({below = false}) end, desc = "Printf" },
      ---@diagnostic disable-next-line: missing-parameter
      { mode = {"x", "n"}, "<leader>rp", function() require('refactoring').debug.print_var() end, desc = "Print Variable" },
      ---@diagnostic disable-next-line: missing-fields
      { mode = "n", "<leader>rc", function() require('refactoring').debug.cleanup({}) end, desc = "Cleanup Print Statements" },
    },
    opts = {
      prompt_func_return_type = {
        go = true,
        java = true,
        cpp = true,
        c = true,
        h = false,
        hpp = false,
        cxx = false,
      },
      prompt_func_param_type = {
        go = true,
        java = true,
        cpp = true,
        c = true,
        h = false,
        hpp = false,
        cxx = false,
      },
      printf_statements = {},
      print_var_statements = {},
      show_success_message = true, -- shows a message with information about the refactor on success
      --                           -- i.e. [Refactor] Inlined 3 variable occurrences
    },
  },
}
