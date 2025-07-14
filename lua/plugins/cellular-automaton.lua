-- https://github.com/Eandrju/cellular-automaton.nvim
-- cellular-automaton for fun animations

return {
  "eandrju/cellular-automaton.nvim",
  enabled = false,
  dependencies = {
    -- add default name in which-key
  },
  cmd = "CellularAutomaton",
  keys = {
    { "<leader>ua", "", mode = "n", desc = "cellular automaton" },
    { "<leader>uar", "<cmd>CellularAutomaton make_it_rain<CR>", mode = "n", desc = "Make it Rain" },
    { "<leader>uag", "<cmd>CellularAutomaton game_of_life<CR>", mode = "n", desc = "Game of Life" },
    { "<leader>uas", "<cmd>CellularAutomaton scramble<CR>", mode = "n", desc = "Scramble" },
  },
}
