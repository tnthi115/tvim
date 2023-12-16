-- cellular-automaton for fun animations

return {
  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    keys = {
      { "<leader>uar", "<cmd>CellularAutomaton make_it_rain<CR>", mode = "n", desc = "Make it Rain" },
      { "<leader>uag", "<cmd>CellularAutomaton game_of_life<CR>", mode = "n", desc = "Game of Life" },
      { "<leader>uas", "<cmd>CellularAutomaton scramble<CR>", mode = "n", desc = "Scramble" },
    },
  },
  -- add default name in which-key
  {
    "folke/which-key.nvim",
    -- opts = {
    --   defaults = {
    --     ["<leader>ua"] = { name = "+Cellular Automaton" },
    --   },
    -- },
    opts = function()
      local status_ok, which_key = pcall(require, "which-key")
      if not status_ok then
        return
      end

      local opts = {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
      }

      local mappings = {
        u = {
          a = {
            name = "+Cellular Automoton",
          },
        },
      }

      which_key.register(mappings, opts)
    end,
  },
}
