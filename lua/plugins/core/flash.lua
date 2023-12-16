-- Full spec: https://www.lazyvim.org/plugins/editor#flashnvim

-- flash.nvim - navigate code with search labels, enhanced character motions, and Treesitter integration
return {
  "folke/flash.nvim",
  event = "User FileOpened",
  ---@type Flash.Config
  opts = {
    modes = {
      -- `f`, `F`, `t`, `T`, `;` and `,` motions
      char = {
        enabled = false,
        jump_labels = true,
      },
    },
  },
  -- stylua: ignore
  keys = {
    -- disable the default flash keymap
    { "s", mode = { "n", "x", "o" }, false },
    -- { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    -- { "<C-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
