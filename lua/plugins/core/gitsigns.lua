-- Full spec: https://www.lazyvim.org/plugins/editor#gitsignsnvim

return {
  "lewis6991/gitsigns.nvim",
  -- event = "LazyFile",
  -- opts = {
  --   signs = {
  --     add = { text = "▎" },
  --     change = { text = "▎" },
  --     delete = { text = "" },
  --     topdelete = { text = "" },
  --     changedelete = { text = "▎" },
  --     untracked = { text = "▎" },
  --   },
  --   on_attach = function(buffer)
  --     local gs = package.loaded.gitsigns
  --
  --     local function map(mode, l, r, desc)
  --       vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
  --     end
  --
  --       -- stylua: ignore start
  --       map("n", "]h", gs.next_hunk, "Next Hunk")
  --       map("n", "[h", gs.prev_hunk, "Prev Hunk")
  --       map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
  --       map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
  --       map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
  --       map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
  --       map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
  --       map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
  --       map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
  --       map("n", "<leader>ghd", gs.diffthis, "Diff This")
  --       map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
  --       map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
  --   end,
  -- },
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
    -- Flatten <leader>gh keybinds into <leader> g menu.
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
