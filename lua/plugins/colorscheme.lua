-- Full spec: https://www.lazyvim.org/plugins/colorscheme

return {
  {
    "folke/tokyonight.nvim",
    opts = function()
      -- local bg_color = "#1a1b26"
      -- vim.cmd [[hi Normal ctermbg=none guibg=none]]
      -- vim.cmd [[hi SignColumn ctermbg=none guibg=none]]
      -- vim.cmd [[hi NormalNC ctermbg=none guibg=none]]
      -- vim.cmd [[hi MsgArea ctermbg=none guibg=none]]
      -- vim.cmd [[hi TelescopeBorder ctermbg=none guibg=none]]
      -- vim.cmd [[hi NvimTreeNormal ctermbg=none guibg=none]]
      -- vim.cmd [[let &fcs='eob: ']]
      -- vim.cmd [[hi NormalFloat ctermbg=none guibg=bg_color]]
      -- vim.cmd [[hi CmpMenu ctermbg=none guibg=bg_color]]
      -- vim.cmd [[hi CmpItemMenu ctermbg=none guibg=bg_color]]
      -- vim.cmd [[hi CmpDocumentation ctermbg=none guibg=bg_color]]
      -- vim.cmd [[hi link CmpMenu NormalFloat]]
      -- vim.cmd [[hi link CmpItemMenu NormalFloat]]
      -- vim.cmd [[hi link CmpDocumentation NormalFloat]]
      -- vim.cmd [[hi FloatShadow ctermbg=none guibg=bg_color]]
      -- vim.cmd [[hi FloatShadowThrough ctermbg=none guibg=bg_color]]
      -- vim.cmd [[hi NoiceMini ctermbg=none guibg=bg_color]]
      -- vim.cmd [[autocmd! ColorScheme * highlight NoiceMini guibg=bg_color]]

      -- TODO: figure out why this doesn't work
      -- local colors = require("tokyonight.colors").setup()
      -- vim.cmd [[hi IndentBlanklineContextChar guifg=colors.fg]]
      return {
        style = "night",
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      }
    end,
  },

  -- {
  --   "LunarVim/lunar.nvim",
  --   -- lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   -- priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     vim.cmd.colorscheme "lunar"
  --
  --     -- vim.api.nvim_create_autocmd("ColorScheme", {
  --     --   pattern = "*",
  --     --   callback = function()
  --     --     local hl_groups = {
  --     --       "Normal",
  --     --       "SignColumn",
  --     --       "NormalNC",
  --     --       "TelescopeBorder",
  --     --       "NvimTreeNormal",
  --     --       "NvimTreeNormalNC",
  --     --       "EndOfBuffer",
  --     --       "MsgArea",
  --     --     }
  --     --     for _, name in ipairs(hl_groups) do
  --     --       vim.cmd(string.format("highlight %s ctermbg=none guibg=none", name))
  --     --     end
  --     --   end,
  --     -- })
  --     -- vim.opt.fillchars = "eob: "
  --
  --     -- vim.cmd [[au ColorScheme * hi Normal ctermbg=none guibg=none]]
  --     -- vim.cmd [[au ColorScheme * hi SignColumn ctermbg=none guibg=none]]
  --     -- vim.cmd [[au ColorScheme * hi NormalNC ctermbg=none guibg=none]]
  --     -- vim.cmd [[au ColorScheme * hi MsgArea ctermbg=none guibg=none]]
  --     -- vim.cmd [[au ColorScheme * hi TelescopeBorder ctermbg=none guibg=none]]
  --     -- vim.cmd [[au ColorScheme * hi NvimTreeNormal ctermbg=none guibg=none]]
  --     -- vim.cmd [[let &fcs='eob: ']]
  --
  --     -- -- lunar theme specific
  --     -- local bg_color = "#1a1b26"
  --     -- vim.cmd [[au ColorScheme * hi NvimTreeWinSeparator ctermbg=none guibg=bg_color]]
  --     -- vim.cmd [[au ColorScheme * hi TabLineFill ctermbg=none guibg=bg_color]]
  --     -- vim.cmd [[au ColorScheme * hi VertSplit ctermbg=none guibg=bg_color]]
  --     -- vim.cmd [[au ColorScheme * hi FloatBorder ctermbg=none guibg=bg_color]]
  --     -- vim.cmd [[au ColorScheme * hi NormalFloat ctermbg=none guibg=bg_color]]
  --     -- vim.cmd [[au ColorScheme * hi WhichKeyFloat ctermbg=none guibg=bg_color]]
  --     -- vim.cmd [[au ColorScheme * hi WhichKeyFloat ctermbg=none guibg=bg_color]]
  --     -- vim.cmd [[au ColorScheme * hi TelescopeNormal ctermbg=none guibg=bg_color]]
  --     -- vim.cmd [[au ColorScheme * hi Folded ctermbg=none guibg=bg_color]]
  --     -- vim.cmd [[au ColorScheme * hi DiagnosticVirtualTextOk ctermbg=none guibg=bg_color]]
  --     -- vim.cmd [[au ColorScheme * hi DiagnosticVirtualTextHint ctermbg=none guibg=bg_color]]
  --     -- vim.cmd [[au ColorScheme * hi DiagnosticVirtualTextInfo ctermbg=none guibg=bg_color]]
  --     -- vim.cmd [[au ColorScheme * hi DiagnosticVirtualTextWarn ctermbg=none guibg=bg_color]]
  --     -- vim.cmd [[au ColorScheme * hi DiagnosticVirtualTextError ctermbg=none guibg=bg_color]]
  --
  --     vim.cmd [[hi Normal ctermbg=none guibg=none]]
  --     vim.cmd [[hi SignColumn ctermbg=none guibg=none]]
  --     vim.cmd [[hi NormalNC ctermbg=none guibg=none]]
  --     vim.cmd [[hi MsgArea ctermbg=none guibg=none]]
  --     vim.cmd [[hi TelescopeBorder ctermbg=none guibg=none]]
  --     vim.cmd [[hi NvimTreeNormal ctermbg=none guibg=none]]
  --     vim.cmd [[let &fcs='eob: ']]
  --
  --     -- lunar theme specific
  --     local bg_color = "#1a1b26"
  --     vim.cmd [[hi NvimTreeWinSeparator ctermbg=none guibg=bg_color]]
  --     vim.cmd [[hi TabLineFill ctermbg=none guibg=bg_color]]
  --     vim.cmd [[hi VertSplit ctermbg=none guibg=bg_color]]
  --     vim.cmd [[hi FloatBorder ctermbg=none guibg=bg_color]]
  --     vim.cmd [[hi NormalFloat ctermbg=none guibg=bg_color]]
  --     vim.cmd [[hi WhichKeyFloat ctermbg=none guibg=bg_color]]
  --     vim.cmd [[hi WhichKeyFloat ctermbg=none guibg=bg_color]]
  --     vim.cmd [[hi TelescopeNormal ctermbg=none guibg=bg_color]]
  --     vim.cmd [[hi Folded ctermbg=none guibg=bg_color]]
  --     vim.cmd [[hi DiagnosticVirtualTextOk ctermbg=none guibg=bg_color]]
  --     vim.cmd [[hi DiagnosticVirtualTextHint ctermbg=none guibg=bg_color]]
  --     vim.cmd [[hi DiagnosticVirtualTextInfo ctermbg=none guibg=bg_color]]
  --     vim.cmd [[hi DiagnosticVirtualTextWarn ctermbg=none guibg=bg_color]]
  --     vim.cmd [[hi DiagnosticVirtualTextError ctermbg=none guibg=bg_color]]
  --     -- vim.cmd [[hi CmpDocumentation ctermbg=none guibg=bg_color]]
  --     -- vim.cmd [[hi CmpItemMenu ctermbg=none guibg=bg_color]]
  --   end,
  -- },
}
