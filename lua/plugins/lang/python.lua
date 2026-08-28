if vim.g.vscode then
  return {}
end

-- Full spec:
-- https://www.lazyvim.org/extras/lang/python
-- https://www.lazyvim.org/extras/formatting/black

return {
  -- { import = "lazyvim.plugins.extras.lang.python" },
  -- Install mason packages.
  {
    "mason-org/mason.nvim",
    ft = { "python" },
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "basedpyright",
        "ruff",
        "pylint",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ft = { "python" },
    opts = {
      servers = {
        -- pyright = {},
        basedpyright = {},
        ruff = {
          -- Ruff LSP provides linting + formatting. Since we already use black for
          -- formatting, disable ruff's formatter to avoid conflicts.
          init_options = {
            settings = {
              lint = {
                select = {
                  "W",
                  "N",
                  "D",
                  "UP",
                  "S",
                  "A",
                  "C4",
                  "ISC",
                  "ICN",
                  "PT",
                  "RET",
                  "SIM",
                  "TID",
                  "TCH",
                  "PL",
                  "TRY",
                  "AIR",
                  "PERF",
                  "FURB",
                  "RUF",
                },
              },
              -- Disable ruff formatting since black is primary formatter
              format = {
                preview = false,
              },
            },
          },
          -- Disable hover to avoid conflicts with basedpyright
          on_attach = function(client, _)
            client.server_capabilities.hoverProvider = false
          end,
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "black", "usort" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "pylint", "mypy" },
      },
      linters = {
        mypy = {
          args = {
            "--show-column-numbers",
            "--show-error-end",
            -- "--hide-error-codes",
            -- "--hide-error-context",
            "--no-color-output",
            "--no-error-summary",
            "--no-pretty",
            "--strict",
            function()
              return "--python-executable=" .. vim.fn.exepath "python"
            end,
          },
        },
      },
    },
  },
  -- {
  --   "linux-cultist/venv-selector.nvim",
  --   ft = { "python" },
  --   cmd = "VenvSelect",
  --   keys = {
  --     { "<leader>jv", ft = "python", "<cmd>:VenvSelect<CR>", desc = "Select VirtualEnv" },
  --   },
  --   opts = function(_, opts)
  --     if require("lazyvim.util").has "nvim-dap-python" then
  --       opts.dap_enabled = true
  --     end
  --
  --     return vim.tbl_deep_extend("force", opts, {
  --       name = {
  --         "venv",
  --         ".venv",
  --         "env",
  --         ".env",
  --       },
  --       -- path = "~/venvs/",
  --       parents = 0,
  --     })
  --   end,
  -- },
}
