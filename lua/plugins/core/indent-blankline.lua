-- Full spec: https://www.lazyvim.org/plugins/ui#indent-blanklinenvim

if true then
  return {}
end

-- return {
--   "lukas-reineke/indent-blankline.nvim",
--   opts = {
--     scope = { enabled = true },
--   },
-- }

-- Use version 2 instead of 3.
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "indent_blankline",
  tag = "v2.20.8",
  opts = function()
    local colors = require("tokyonight.colors").setup()
    vim.cmd [[hi IndentBlanklineContextChar guifg=colors.fg]]
    -- vim.cmd [[autocmd! ColorScheme * hi default link IndentBlanklineContextChar Normal]]
    -- vim.cmd [[hi default link IndentBlanklineContextChar Normal]]
    return {
      scope = { enabled = true },
      show_trailing_blankline_indent = false,
      show_first_indent_level = true,
      use_treesitter = true,
      show_current_context = true,
    }
  end,
}
