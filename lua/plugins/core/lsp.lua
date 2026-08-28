-- Full spec: https://www.lazyvim.org/plugins/lsp

-- Language specs:
-- https://www.lazyvim.org/extras/lang/docker
-- https://www.lazyvim.org/extras/lang/go
-- https://www.lazyvim.org/extras/lang/json
-- https://www.lazyvim.org/extras/lang/markdown
-- https://www.lazyvim.org/extras/lang/python
-- https://www.lazyvim.org/extras/formatting/black
-- https://www.lazyvim.org/extras/lang/yaml

-- Rounded borders:
-- https://github.com/LazyVim/LazyVim/issues/2708

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        float = {
          border = "rounded",
        },
      },
      -- codelens = {
      --   enabled = true,
      -- },
    },
    -- opts = function(_, opts)
    --   require("lspconfig.ui.windows").default_options.border = "single"
    --
    --   opts.diagnostic = {
    --     -- underline = true,
    --     -- update_in_insert = false,
    --     -- virtual_text = {
    --     --   spacing = 4,
    --     --   source = "if_many",
    --     --   prefix = "●",
    --     --   -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
    --     --   -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
    --     --   -- prefix = "icons",
    --     -- },
    --     float = {
    --       border = "rounded",
    --     },
    --     -- severity_sort = true,
    --   }
    --   -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
    --   -- Be aware that you also will need to properly configure your LSP server to
    --   -- provide the inlay hints.
    --   opts.inlay_hints = {
    --     enabled = true,
    --   }
    --   -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
    --   -- Be aware that you also will need to properly configure your LSP server to
    --   -- provide the code lenses.
    --   opts.codelens = {
    --     enabled = true,
    --   }
    -- end,
  },
  {

    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          -- https://www.lazyvim.org/plugins/lsp#%EF%B8%8F-customizing-lsp-keymaps
          keys = {
            { "<c-k>", false },
            -- { "K", require("pretty_hover").hover() }
          },
        },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    dependencies = {
      -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        event = "LspAttach",
        cmd = {
          "MasonToolsInstall",
          "MasonToolsInstallSync",
          "MasonToolsUpdate",
          "MasonToolsUpdateSync",
          "MasonToolsClean",
        },
      },
    },
    opts = function(_, opts)
      -- Manually setup mason-tool-installer
      require("mason-tool-installer").setup {
        -- Pass the ensure_installed list from mason to mason-tool-installer.
        ensure_installed = opts.ensure_installed,
        -- This doesn't work when mason-tool-installer is loaded on LspAttach.
        auto_update = true,
        run_on_start = false,
      }

      -- -- Create autocommand to automatically update mason packages on the LspAttach event.
      -- vim.api.nvim_create_autocmd("LspAttach", {
      --   callback = function()
      --     vim.cmd "MasonToolsUpdate"
      --   end,
      -- })

      opts.ui = {
        border = "rounded",
      }
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "LspAttach",
    -- keys = {
    --   {
    --     "<leader>uu",
    --     Toggle_lsp_lines,
    --     desc = "Toggle lsp_lines Diagnostics",
    --   },
    -- },
    config = function()
      require("lsp_lines").setup()

      vim.diagnostic.config {
        virtual_text = true,
        virtual_lines = {
          only_current_line = true,
          highlight_whole_line = false,
        },
      }

      -- -- Disable for certain filetypes
      -- local disabled_filetypes = { "lazy", "mason" }
      --
      -- -- Custom functionality:
      -- -- Hide LSP virtual text diagnostics and show lsp_lines on the current cursor line only
      -- Custom_diag_ns = vim.api.nvim_create_namespace "custom_diag_hide_cursor"
      -- Custom_diag_augroup = vim.api.nvim_create_augroup("custom_diag_hide_cursor", { clear = true })
      --
      -- local function create_show_diagnostics_except_cursor_autocmd(disabled_filetypes_list)
      --   vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufEnter", "InsertLeave" }, {
      --     group = Custom_diag_augroup,
      --     callback = function()
      --       local bufnr = vim.api.nvim_get_current_buf()
      --       local filetype = vim.bo.filetype
      --       if vim.tbl_contains(disabled_filetypes_list, filetype) then
      --         return
      --       end
      --       local cursor_line = vim.api.nvim_win_get_cursor(0)[1] - 1 -- 0-indexed
      --       vim.diagnostic.hide(Custom_diag_ns, bufnr)
      --       local diagnostics = vim.diagnostic.get(bufnr)
      --       local filtered = {}
      --       for _, d in ipairs(diagnostics) do
      --         if d.lnum ~= cursor_line then
      --           table.insert(filtered, d)
      --         end
      --       end
      --       vim.diagnostic.show(Custom_diag_ns, bufnr, filtered, { virtual_text = true, virtual_lines = false })
      --     end,
      --   })
      -- end
      --
      -- create_show_diagnostics_except_cursor_autocmd(disabled_filetypes)
      --
      -- function Toggle_lsp_lines()
      --   local config = vim.diagnostic.config()
      --   if config and config.virtual_lines ~= false then
      --     -- Switch to lsp_lines state
      --     require("lsp_lines").toggle()
      --     vim.diagnostic.config {
      --       virtual_text = false,
      --       virtual_lines = {
      --         only_current_line = true,
      --         highlight_whole_line = false,
      --       },
      --     }
      --     create_show_diagnostics_except_cursor_autocmd(disabled_filetypes)
      --   else
      --     -- Switch to normal virtual_text only state
      --     require("lsp_lines").toggle()
      --     vim.diagnostic.config {
      --       virtual_text = true,
      --       virtual_lines = false,
      --     }
      --     vim.api.nvim_clear_autocmds { group = Custom_diag_augroup }
      --   end
      -- end
    end,
  },
  -- Stops inactive LSP clients to free RAM.
  -- https://github.com/Zeioth/garbage-day.nvim?tab=readme-ov-file
  {
    "zeioth/garbage-day.nvim",
    enabled = false,
    dependencies = "neovim/nvim-lspconfig",
    event = "LspAttach",
    opts = {
      -- your options here
      aggressive_mode = false,
      grace_period = 60 * 15,
      wakeup_delay = 0,
    },
  },
  -- LSP mouse hover
  {
    "seblj/nvim-lsp-extras",
    enabled = false,
    dependencies = {
      {
        "folke/noice.nvim",
        opts = {
          lsp = {
            -- disable overrides so that seblj/nvim-lsp-extras can set these
            override = {
              ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
              ["vim.lsp.util.stylize_markdown"] = false,
              ["cmp.entry.get_documentation"] = false,
            },
          },
        },
      },
    },
    event = "LspAttach",
    config = function()
      vim.o.mousemoveevent = true

      require("nvim-lsp-extras").setup {
        signature = false,
        lightbulb = false,
      }
    end,
  },
  -- https://github.com/jmbuhr/otter.nvim
  {
    "jmbuhr/otter.nvim",
    -- event = "LspAttach",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "OtterActivate", "OtterDeactivate", "OtterExport", "OtterExportAs" },
    keys = {
      {
        "<leader>cuo",
        function()
          require("otter").activate()
        end,
        desc = "Activate Otter",
      },
      {
        "<leader>cuO",
        function()
          require("otter").deactivate()
        end,
        desc = "Deactivate Otter",
      },
    },
    config = true,
    -- opts = function(_, opts)
    --   -- Activate Otter when entering a markdown file
    --   vim.api.nvim_create_autocmd("FileType", {
    --     pattern = "markdown",
    --     callback = function()
    --       require("otter").activate()
    --     end,
    --   })
    -- end,
  },
  -- https://github.com/kosayoda/nvim-lightbulb
  -- {
  --   "kosayoda/nvim-lightbulb",
  --   event = "LspAttach",
  --   opts = {
  --     code_lenses = true,
  --     sign = {
  --       enabled = false,
  --     },
  --     line = {
  --       enabled = false,
  --       -- Highlight group to highlight the line if there is a lightbulb.
  --       hl = "LightBulbLine",
  --     },
  --     virtual_text = {
  --       enabled = true,
  --       -- Text to show in the virt_text.
  --       text = "💡",
  --       lens_text = "🔎",
  --       -- Position of virtual text given to |nvim_buf_set_extmark|.
  --       -- Can be a number representing a fixed column (see `virt_text_pos`).
  --       -- Can be a string representing a position (see `virt_text_win_col`).
  --       pos = "eol",
  --       -- Highlight group to highlight the virtual text.
  --       hl = "LightBulbVirtualText",
  --       -- How to combine other highlights with text highlight.
  --       -- See `hl_mode` of |nvim_buf_set_extmark|.
  --       hl_mode = "combine",
  --     },
  --     float = {
  --       enabled = false,
  --       -- Text to show in the floating window.
  --       text = "💡",
  --       lens_text = "🔎",
  --       -- Highlight group to highlight the floating window.
  --       hl = "LightBulbFloatWin",
  --       -- Window options.
  --       -- See |vim.lsp.util.open_floating_preview| and |nvim_open_win|.
  --       -- Note that some options may be overridden by |open_floating_preview|.
  --       win_opts = {
  --         focusable = false,
  --       },
  --     },
  --     autocmd = {
  --       enabled = true,
  --       updatetime = 50,
  --     },
  --     ignore = {
  --       -- Ignore code actions without a `kind` like refactor.rewrite, quickfix.
  --       actions_without_kind = true,
  --     },
  --   },
  -- },
}
