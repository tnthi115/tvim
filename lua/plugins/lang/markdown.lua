-- Full spec: -- https://www.lazyvim.org/extras/lang/markdown

return {
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = function(_, opts)
  --     if type(opts.ensure_installed) == "table" then
  --       vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline" })
  --     end
  --   end,
  -- },
  {
    "williamboman/mason.nvim",
    ft = { "markdown" },
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "markdownlint", "marksman" })
    end,
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       marksman = {},
  --     },
  --   },
  -- },
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   build = function()
  --     vim.fn["mkdp#util#install"]()
  --   end,
  --   keys = {
  --     {
  --       "<leader>cp",
  --       ft = "markdown",
  --       "<cmd>MarkdownPreviewToggle<cr>",
  --       desc = "Markdown Preview",
  --     },
  --   },
  --   config = function()
  --     vim.cmd [[do FileType]]
  --   end,
  -- },
  -- {
  --   "lukas-reineke/headlines.nvim",
  --   opts = function()
  --     local opts = {}
  --     for _, ft in ipairs { "markdown", "norg", "rmd", "org" } do
  --       opts[ft] = {
  --         headline_highlights = {},
  --       }
  --       for i = 1, 6 do
  --         local hl = "Headline" .. i
  --         vim.api.nvim_set_hl(0, hl, { link = "Headline", default = true })
  --         table.insert(opts[ft].headline_highlights, hl)
  --       end
  --     end
  --     return opts
  --   end,
  --   ft = { "markdown", "norg", "rmd", "org" },
  --   config = function(_, opts)
  --     -- PERF: schedule to prevent headlines slowing down opening a file
  --     vim.schedule(function()
  --       require("headlines").setup(opts)
  --       require("headlines").refresh()
  --     end)
  --   end,
  -- },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   ft = { "markdown" },
  --   opts = function(_, opts)
  --     local nls = require "null-ls"
  --     opts.sources = vim.list_extend(opts.sources or {}, {
  --       nls.builtins.diagnostics.markdownlint,
  --       nls.builtins.formatting.mdformat.with {
  --         extra_args = { "--number" },
  --       },
  --     })
  --   end,
  -- },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint", "codespell" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    -- NOTE: For github flavored markdown use this extension: https://github.com/hukkin/mdformat-gfm/
    -- pip install mdformat-gfm
    -- This will create the executable in /opt/homebrew/bin/mdformat.
    -- Running the mdformat binary installed from mason will not have these features!
    -- Asked about adding mdformat-gfm in mason-registry:
    -- https://github.com/mason-org/mason-registry/pull/2132#issuecomment-1865412278
    opts = {
      formatters_by_ft = {
        markdown = { "mdformat" },
      },
      formatters = {
        mdformat = {
          prepend_args = { "--number" },
        },
      },
    },
  },
}
