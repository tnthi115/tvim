-- Full spec: https://www.lazyvim.org/plugins/colorscheme

return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      --- You can override specific highlights to use other groups or a hex color
      --- function will be called with a Highlights and ColorScheme table
      ---@param highlights tokyonight.Highlights
      ---@param colors ColorScheme
      on_highlights = function(hl, c)
        hl.LspInlayHint = {
          bg = "none",
          -- fg = "#545c7e",
          fg = c.comment,
        }
        -- hl.LineNr = {
        --   bg = "none",
        --   fg = c.comment,
        -- }
      end,
    },
  },

  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     local transparent = true
  --
  --     require("catppuccin").setup {
  --       flavour = transparent and "mocha" or "macchiato",
  --       transparent_background = transparent,
  --       styles = {
  --         keywords = { "bold" },
  --         functions = { "italic" },
  --       },
  --       integrations = {
  --         alpha = false,
  --         neogit = false,
  --         nvimtree = false,
  --         illuminate = false,
  --         rainbow_delimiters = false,
  --         dropbar = { enabled = false },
  --         mason = true,
  --         noice = true,
  --         notify = true,
  --         neotree = true,
  --         neotest = true,
  --         which_key = true,
  --         telescope = { style = transparent and nil or "nvchad" },
  --       },
  --       custom_highlights = function(colors)
  --         return {
  --           -- custom
  --           PanelHeading = {
  --             fg = colors.lavender,
  --             bg = transparent and colors.none or colors.crust,
  --             style = { "bold", "italic" },
  --           },
  --
  --           -- lazy.nvim
  --           LazyH1 = {
  --             bg = transparent and colors.none or colors.peach,
  --             fg = transparent and colors.lavender or colors.base,
  --             style = { "bold" },
  --           },
  --           LazyButton = {
  --             bg = colors.none,
  --             fg = transparent and colors.overlay0 or colors.subtext0,
  --           },
  --           LazyButtonActive = {
  --             bg = transparent and colors.none or colors.overlay1,
  --             fg = transparent and colors.lavender or colors.base,
  --             style = { "bold" },
  --           },
  --           LazySpecial = { fg = colors.green },
  --
  --           CmpItemMenu = { fg = colors.subtext1 },
  --           MiniIndentscopeSymbol = { fg = colors.overlay0 },
  --
  --           FloatBorder = {
  --             fg = transparent and colors.blue or colors.mantle,
  --             bg = transparent and colors.none or colors.mantle,
  --           },
  --
  --           FloatTitle = {
  --             fg = transparent and colors.lavender or colors.base,
  --             bg = transparent and colors.none or colors.lavender,
  --           },
  --         }
  --       end,
  --       color_overrides = {
  --         mocha = {
  --           red = "#f07c82",
  --           blue = "#70a1ff",
  --           green = "#7bed9f",
  --           yellow = "#ffeaa7",
  --
  --           sky = "#5ef1ff",
  --           pink = "#ffacfc",
  --           peach = "#ffbe76",
  --         },
  --       },
  --     }
  --     -- vim.cmd.colorscheme "catppuccin"
  --     -- local palette = require("catppuccin.palettes").get_palette()
  --     -- require("mvim.config").filling_pigments(palette)
  --   end,
  -- },
}
