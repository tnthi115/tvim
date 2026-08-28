-- https://github.com/andythigpen/nvim-coverage

local filetypes = { "go" }

return {
  {
    "andythigpen/nvim-coverage",
    ft = filetypes,
    dependencies = "nvim-lua/plenary.nvim",
    -- Optional: needed for PHP when using the cobertura parser
    rocks = { "lua-xmlreader" },
    cmd = {
      "Coverage",
      "CoverageHide",
      "CoverageLoad",
      "CoverageShow",
      "CoverageClear",
      "CoverageToggle",
      "CoverageSummary",
      "CoverageLoadLcov",
    },
    keys = {
      { "<leader>mv", "", desc = "code coverage", ft = filetypes },
      { "<leader>mvc", "<cmd>Coverage<CR>", desc = "Load and Display Coverage Report", ft = filetypes },
      { "<leader>mvl", "<cmd>CoverageLoad<CR>", desc = "Load Coverage Report", ft = filetypes },
      { "<leader>mvt", "<cmd>CoverageToggle<CR>", desc = "Toggle Coverage Signs", ft = filetypes },
      { "<leader>mvt", "<cmd>CoverageToggle<CR>", desc = "Toggle Coverage Signs", ft = filetypes },
      { "<leader>mvq", "<cmd>CoverageClear<CR>", desc = "Unload Cached Coverage Signs", ft = filetypes },
      { "<leader>mvs", "<cmd>CoverageSummary<CR>", desc = "Coverage Summary", ft = filetypes },
    },
    opts = {
      commands = true, -- create commands
      highlights = {
        -- customize highlight groups created by the plugin
        covered = { fg = "#C3E88D" }, -- supports style, fg, bg, sp (see :h highlight-gui)
        uncovered = { fg = "#F07178" },
      },
      signs = {
        -- use your own highlight groups or text markers
        covered = { hl = "CoverageCovered", text = "▎" },
        uncovered = { hl = "CoverageUncovered", text = "▎" },
      },
      summary = {
        -- customize the summary pop-up
        min_coverage = 80.0, -- minimum coverage threshold (used for highlighting)
      },
      lang = {
        -- customize language specific settings
        go = {
          coverage_file = "coverage_out/cmd-unittest-opt-bl",
        },
      },
    },
  },
}
