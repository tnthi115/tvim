-- https://github.com/folke/sidekick.nvim

return {
  "folke/sidekick.nvim",
  keys = {
    {
      "<leader>ao",
      function()
        require("sidekick.cli").toggle { name = "opencode", focus = true }
      end,
      desc = "Sidekick Opencode Toggle",
    },
  },
  opts = {
    cli = {
      mux = {
        backend = "tmux",
        enabled = true,
      },
      tools = {
        opencode = {
          cmd = { "opencode" },
          -- HACK: https://github.com/sst/opencode/issues/445
          env = { OPENCODE_THEME = "tymon-kanagawa" },
          url = "https://github.com/sst/opencode",
        },
      },
    },
  },
}
