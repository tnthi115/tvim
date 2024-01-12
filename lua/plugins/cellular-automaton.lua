-- https://github.com/Eandrju/cellular-automaton.nvim
-- cellular-automaton for fun animations

return {
  "eandrju/cellular-automaton.nvim",
  dependencies = {
    -- add default name in which-key
    {
      "folke/which-key.nvim",
      opts = function(_, opts)
        opts.defaults["<leader>ua"] = { name = "+cellular automaton" }
      end,
    },
  },
  cmd = "CellularAutomaton",
  keys = {
    { "<leader>uar", "<cmd>CellularAutomaton make_it_rain<CR>", mode = "n", desc = "Make it Rain" },
    { "<leader>uag", "<cmd>CellularAutomaton game_of_life<CR>", mode = "n", desc = "Game of Life" },
    { "<leader>uas", "<cmd>CellularAutomaton scramble<CR>", mode = "n", desc = "Scramble" },
  },
}
