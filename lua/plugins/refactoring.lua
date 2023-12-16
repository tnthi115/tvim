-- refactoring

return {
  "ThePrimeagen/refactoring.nvim",
    -- stylua: ignore
    keys = {
      -- visual mode
      { "<leader>re", "<Esc><cmd>lua require('refactoring').refactor('Extract Function')<CR>", mode = "v", desc = "Extract Function" },
      { "<leader>rf", "<Esc><cmd>lua require('refactoring').refactor('Extract Function To File')<CR>", mode = "v", desc = "Extract Function To File" },
      { "<leader>rv", "<Esc><cmd>lua require('refactoring').refactor('Extract Variable')<CR>", mode = "v", desc = "Extract Variable" },
      { "<leader>ri", "<Esc><cmd>lua require('refactoring').refactor('Inline Variable')<CR>", mode = "v", desc = "Inline Variable" },
      -- normal mode
      -- Inline variable can also pick up the identifier currently under the cursor without visual mode
      { "<leader>ri", "<cmd>lua require('refactoring').refactor('Inline Variable')<CR>", mode = "n", desc = "Inline Variable" },
      { "<leader>rb", "<cmd>lua require('refactoring').refactor('Extract Block')<CR>", mode = "n", desc = "Extract Block" },
      -- Extract block doesn't need visual mode
      { "<leader>rB", "<cmd>lua require('refactoring').refactor('Extract Block To File')<CR>", mode = "n", desc = "Extract Block To File" },
    },
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-treesitter/nvim-treesitter" },
  },
  config = function()
    require("refactoring").setup {
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
    }
  end,
}
