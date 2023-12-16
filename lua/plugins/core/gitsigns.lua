-- Full spec: https://www.lazyvim.org/plugins/editor#gitsignsnvim

return {
  "lewis6991/gitsigns.nvim",
  keys = {
    -- TODO: this doesn't work
    -- Disable the default keybinds for the <leader>gh hunks group.
    { "<leader>ghs", false },
    { "<leader>ghr", false },
    { "<leader>ghS", false },
    { "<leader>ghu", false },
    { "<leader>ghR", false },
    { "<leader>ghp", false },
    { "<leader>ghb", false },
    { "<leader>ghd", false },
    { "<leader>ghD", false },
    -- Flatten <leader>gh keybinds into <leader>g menu.
    { "<leader>gj", mode = "n", require("gitsigns").next_hunk, desc = "Next Hunk" },
    { "<leader>gk", mode = "n", require("gitsigns").prev_hunk, desc = "Prev Hunk" },
    { "<leader>gs", mode = { "n", "v" }, ":Gitsigns stage_hunk<CR>", desc = "Stage Hunk" },
    { "<leader>gr", mode = { "n", "v" }, ":Gitsigns reset_hunk<CR>", desc = "Reset Hunk" },
    { "<leader>gS", mode = "n", require("gitsigns").stage_buffer, desc = "Stage Buffer" },
    { "<leader>gu", mode = "n", require("gitsigns").undo_stage_hunk, desc = "Undo Stage Hunk" },
    { "<leader>gR", mode = "n", require("gitsigns").reset_buffer, desc = "Reset Buffer" },
    { "<leader>gp", mode = "n", require("gitsigns").preview_hunk, desc = "Preview Hunk" },
    -- stylua: ignore
    { "<leader>gl", mode = "n",  function() require("gitsigns").blame_line({ full = true }) end, desc = "Blame Line" },
    { "<leader>gd", mode = "n", require("gitsigns").diffthis, desc = "Diff This" },
    -- stylua: ignore
    { "<leader>gD", mode = "n", function() require("gitsigns").diffthis("~") end, desc = "Diff This ~" },
  },
}
