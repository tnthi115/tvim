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
        -- "ruff-lsp",
        -- TODO: setup ruff with rules and server mode
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
        -- ruff_lsp = {
        --   init_options = {
        --     settings = {
        --       -- Any extra CLI arguments for `ruff` go here.
        --       -- See https://beta.ruff.rs/docs/rules/
        --       args = { "--extend-select=W,N,D,UP,S,A,C4,ISC,ICN,PT,RET,SIM,TID,TCH,PL,TRY,AIR,PERF,FURB,RUF" },
        --     },
        --   },
        -- },
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
          -- Cache the Python path for performance
          -- The Python path is determined during plugin setup rather than during config load
          setup = function(linter)
            -- Set python path during setup (runs only when linter is actually used)
            if not linter.args_python_path_set then
              local python_path = vim.fn.exepath "python"
              table.insert(linter.args, "--python-executable=" .. python_path)
              linter.args_python_path_set = true
            end
          end,
          args = {
            "--show-column-numbers",
            "--show-error-end",
            -- "--hide-error-codes",
            -- "--hide-error-context",
            "--no-color-output",
            "--no-error-summary",
            "--no-pretty",
            "--strict",
            -- Python executable path moved to setup function for better performance
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
