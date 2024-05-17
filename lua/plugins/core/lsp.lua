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
      codelens = {
        enabled = true,
      },
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
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
}
