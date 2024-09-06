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

-- local function toggle_lsp_lines()
--   require("lsp_lines").toggle()
--   local new_value = not vim.diagnostic.config().virtual_text
--   vim.diagnostic.config { virtual_text = new_value }
--   return new_value
-- end

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
    opts = function()
      require("lspconfig.ui.windows").default_options.border = "rounded"
    end,
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        event = "LspAttach",
        cmd = {
          "MasonToolsInstall",
          "MasonToolsIntallSync",
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
        run_on_start = true,
      }

      -- Create autocommand to automatically update mason packages on the LspAttach event.
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function()
          vim.cmd "MasonToolsUpdate"
        end,
      })

      return {
        ui = {
          border = "rounded",
        },
      }
    end,
  },
  -- {
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   enabled = false,
  --   event = "LspAttach",
  --   keys = {
  --     {
  --       "<leader>uD",
  --       toggle_lsp_lines,
  --       desc = "Toggle lsp_lines Diagnostics",
  --     },
  --   },
  --   config = function()
  --     require("lsp_lines").setup()
  --
  --     vim.diagnostic.config {
  --       virtual_text = false,
  --     }
  --
  --     -- Disable for certain filetypes
  --     local disabled_filetypes = { "lazy" }
  --
  --     -- TODO: this is maybe jank, but it works for now
  --
  --     -- Toggle off lsp_lines when entering lazy
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = disabled_filetypes,
  --       callback = function()
  --         if vim.bo.filetype == "lazy" and vim.diagnostic.config().virtual_text == false then
  --           toggle_lsp_lines()
  --         end
  --       end,
  --     })
  --     -- Toggle lsp_lines back on when leaving lazy
  --     vim.api.nvim_create_autocmd("BufLeave", {
  --       callback = function()
  --         for _, v in ipairs(disabled_filetypes) do
  --           if vim.bo.filetype == v and vim.diagnostic.config().virtual_text == true then
  --             toggle_lsp_lines()
  --             return
  --           end
  --         end
  --       end,
  --     })
  --   end,
  -- },
  -- Stops inactive LSP clients to free RAM.
  -- https://github.com/Zeioth/garbage-day.nvim?tab=readme-ov-file
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "LspAttach",
    opts = {
      -- your options here
      aggressive_mode = false,
      grace_period = 60 * 15,
      wakeup_delay = 0,
    },
  },
}
