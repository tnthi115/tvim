-- Full spec: https://www.lazyvim.org/plugins/editor#todo-commentsnvim

return {
  "folke/todo-comments.nvim",
  opts = {
    highlight = {
      keyword = "bg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
      -- after = "empty", -- "fg" or "bg" or empty
      -- pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
      pattern = [[.*<(KEYWORDS)\s*:*]], -- pattern or table of patterns, used for highlightng (vim regex)
    },
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
    -- pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
    pattern = [[\b(KEYWORDS):*\b]], -- match 0 or more ':' followed by a Unicode word boundary
  },
}
