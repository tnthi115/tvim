-- Full spec: https://www.lazyvim.org/plugins/colorscheme

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
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
        hl.BufferLineBackground = {
          bg = "none",
        }
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
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      compile = false, -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = true, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      theme = "wave",
      background = { -- map the value of 'background' option to a theme
        dark = "wave", -- try "dragon" !
        light = "lotus",
      },
      colors = {
        palette = {
          -- oldWhite = "#C8C093", -- default
          -- fujiWhite = "#DCD7BA", -- default
          -- oldWhite = "#DCD7BA",
          -- fujiWhite = "#DCD7BA",
          -- Use the same color for both Whites, and make it less warm
          oldWhite = "#e8e4d8",
          fujiWhite = "#e8e4d8",
        },
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors)
        -- colors: https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/colors.lua
        -- themes: https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/themes.lua
        local theme = colors.theme

        local makeDiagnosticColor = function(color)
          local c = require "kanagawa.lib.color"
          return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
        end

        return {
          -- Dark completion (popup) menu
          -- Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_m3, blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
          -- PmenuSel = { fg = "NONE", bg = theme.ui.bg_p1 },
          -- PmenuSbar = { bg = theme.ui.bg_m3 },
          -- PmenuThumb = { bg = theme.ui.bg_m3 },

          -- Transparent completion (popup) menu
          Pmenu = { fg = theme.ui.shade0, bg = "none", blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = "none", bg = theme.ui.bg_p1 },
          PmenuSbar = { bg = "none" },
          PmenuThumb = { bg = theme.ui.bg_p1 },
          BlinkCmpMenuBorder = { bg = "none" },

          -- Cursor line
          CursorLineNr = { fg = theme.ui.special, bold = true },
          CursorLine = { bg = theme.ui.bg_p1 },

          -- Tint background of diagnostic messages with their foreground color
          DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
          DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
          DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
          DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),

          -- Transparent windows
          NormalFloat = { bg = "none" },
          FloatBorder = { fg = theme.ui.pmenu.bg_sel, bg = "none" },
          FloatTitle = { bg = "none" },

          -- Save an hlgroup with dark background and dimmed foreground
          -- so that you can use it where your still want darker windows.
          -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          -- LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          -- MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

          -- Avante
          -- AvanteSidebarWinSeparator = { fg = theme.ui.pmenu.bg_sel },
          AvanteSidebarWinSeparator = { fg = theme.ui.bg_m3 },

          -- Mini
          MiniFilesTitle = { bg = "none" },
          MiniFilesTitleFocused = { bg = "none" },
        }
      end,
    },
  },
  -- {
  --   "thesimonho/kanagawa-paper.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     transparent = true,
  --     overrides = function(colors)
  --       -- colors: https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/colors.lua
  --       -- themes: https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/themes.lua
  --       local theme = colors.theme
  --
  --       local makeDiagnosticColor = function(color)
  --         local c = require "kanagawa.lib.color"
  --         return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
  --       end
  --
  --       return {
  --         -- Dark completion (popup) menu
  --         -- Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_m3, blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
  --         -- PmenuSel = { fg = "NONE", bg = theme.ui.bg_p1 },
  --         -- PmenuSbar = { bg = theme.ui.bg_m3 },
  --         -- PmenuThumb = { bg = theme.ui.bg_m3 },
  --
  --         -- Transparent completion (popup) menu
  --         Pmenu = { fg = theme.ui.shade0, bg = "none", blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
  --         PmenuSel = { fg = "none", bg = theme.ui.bg_p1 },
  --         PmenuSbar = { bg = "none" },
  --         PmenuThumb = { bg = theme.ui.bg_p1 },
  --         BlinkCmpMenuBorder = { bg = "none" },
  --
  --         -- Cursor line
  --         CursorLineNr = { fg = theme.ui.special, bold = true },
  --         CursorLine = { bg = theme.ui.bg_p1 },
  --
  --         -- Tint background of diagnostic messages with their foreground color
  --         DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
  --         DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
  --         DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
  --         DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
  --
  --         -- Transparent windows
  --         NormalFloat = { bg = "none" },
  --         FloatBorder = { fg = theme.ui.pmenu.bg_sel, bg = "none" },
  --         FloatTitle = { bg = "none" },
  --
  --         -- Save an hlgroup with dark background and dimmed foreground
  --         -- so that you can use it where your still want darker windows.
  --         -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
  --         NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
  --
  --         -- Popular plugins that open floats will link to NormalFloat by default;
  --         -- set their background accordingly if you wish to keep them dark and borderless
  --         -- LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
  --         -- MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
  --
  --         -- Avante
  --         -- AvanteSidebarWinSeparator = { fg = theme.ui.pmenu.bg_sel },
  --         AvanteSidebarWinSeparator = { fg = theme.ui.bg_m3 },
  --       }
  --     end,
  --   },
  -- },
  -- {
  --   "AlexvZyl/nordic.nvim",
  --   -- lazy = false,
  --   -- priority = 1000,
  --   config = function()
  --     -- require("nordic").load()
  --     require("nordic").setup {
  --       -- This callback can be used to override the colors used in the base palette.
  --       on_palette = function(palette) end,
  --       -- This callback can be used to override the colors used in the extended palette.
  --       after_palette = function(palette) end,
  --       -- This callback can be used to override highlights before they are applied.
  --       on_highlight = function(highlights, palette) end,
  --       -- Enable bold keywords.
  --       bold_keywords = false,
  --       -- Enable italic comments.
  --       italic_comments = true,
  --       -- Enable editor background transparency.
  --       transparent = {
  --         -- Enable transparent background.
  --         bg = false,
  --         -- Enable transparent background for floating windows.
  --         float = false,
  --       },
  --       -- Enable brighter float border.
  --       bright_border = false,
  --       -- Reduce the overall amount of blue in the theme (diverges from base Nord).
  --       reduced_blue = true,
  --       -- Swap the dark background with the normal one.
  --       swap_backgrounds = false,
  --       -- Cursorline options.  Also includes visual/selection.
  --       cursorline = {
  --         -- Bold font in cursorline.
  --         bold = false,
  --         -- Bold cursorline number.
  --         bold_number = true,
  --         -- Available styles: 'dark', 'light'.
  --         theme = "dark",
  --         -- Blending the cursorline bg with the buffer bg.
  --         blend = 0.85,
  --       },
  --       noice = {
  --         -- Available styles: `classic`, `flat`.
  --         style = "classic",
  --       },
  --       telescope = {
  --         -- Available styles: `classic`, `flat`.
  --         style = "classic",
  --       },
  --       leap = {
  --         -- Dims the backdrop when using leap.
  --         dim_backdrop = false,
  --       },
  --       ts_context = {
  --         -- Enables dark background for treesitter-context window
  --         dark_background = false,
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   "mellow-theme/mellow.nvim",
  -- },
  -- {
  --   "webhooked/kanso.nvim",
  --   lazy = false,
  --   priority = 1000,
  -- },
}
