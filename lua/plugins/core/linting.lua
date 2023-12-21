-- Full spec: https://www.lazyvim.org/plugins/linting

return {
  {
    "mfussenegger/nvim-lint",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "commitlint", "codespell", "shellcheck" })
        end,
      },
    },
    opts = {
      -- Event to trigger linters
      -- events = { "BufWritePost", "BufReadPost", "InsertLeave", "InsertEnter" },
      linters_by_ft = {
        -- fish = { "fish" },
        -- Use the "*" filetype to run linters on all filetypes.
        -- ['*'] = { 'global linter' },
        -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
        -- ['_'] = { 'fallback linter' },
        gitcommit = { "commitlint", "codespell" },
        html = { "codespell" },
        xthml = { "codespell" },
        sh = { "shellcheck" },
        bash = { "shellcheck" },
      },
      -- LazyVim extension to easily override linter options
      -- or add custom linters.
      ---@type table<string,table>
      linters = {
        -- -- Example of using selene only when a selene.toml file is present
        -- selene = {
        --   -- `condition` is another LazyVim extension that allows you to
        --   -- dynamically enable/disable linters based on the context.
        --   condition = function(ctx)
        --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
        -- codespell = {
        --   condition = function(ctx)
        --     local approved_filetypes = { markdown = true, html = true, xhtml = true, gitcommit = true }
        --     local current_filetype = vim.bo.filetype
        --     return approved_filetypes[current_filetype] == true
        --   end,
        -- },
        shellcheck = {
          args = { "--serverity", "warning" },
        },
      },
    },
  },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   dependencies = {
  --     {
  --       "williamboman/mason.nvim",
  --       opts = function(_, opts)
  --         opts.ensure_installed = opts.ensure_installed or {}
  --         vim.list_extend(opts.ensure_installed, { "commitlint", "codespell", "shellcheck" })
  --       end,
  --     },
  --   },
  --   opts = function(_, opts)
  --     local nls = require "null-ls"
  --     opts.sources = vim.list_extend(opts.sources or {}, {
  --       nls.builtins.diagnostics.commitlint,
  --       nls.builtins.diagnostics.codespell.with {
  --         filetypes = { "markdown", "html", "xhtml", "gitcommit" },
  --       },
  --       nls.builtins.diagnostics.shellcheck.with {
  --         extra_args = { "--severity", "warning" },
  --       },
  --     })
  --   end,
  -- },
}
