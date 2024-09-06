-- Full spec: https://www.lazyvim.org/extras/lang/git

return {
  {
    "mfussenegger/nvim-lint",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "commitlint" })
        end,
      },
    },
    opts = {
      linters_by_ft = {
        gitcommit = { "commitlint", "codespell" },
        NeogitCommitMessage = { "commitlint", "codespell" },
      },
    },
  },
  -- Conventional commits completion in cmp
  {
    "davidsierradz/cmp-conventionalcommits",
    ft = { "gitcommit", "NeogitCommitMessage" },
    dependencies = "hrsh7th/nvim-cmp",
    config = function()
      require("cmp").setup.buffer {
        sources = require("cmp").config.sources({ { name = "conventionalcommits" } }, { { name = "buffer" } }),
      }
    end,
  },
}
