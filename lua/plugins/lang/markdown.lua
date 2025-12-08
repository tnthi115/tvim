-- Full spec: -- https://www.lazyvim.org/extras/lang/markdown
-- Don't need this anymore as the extra has everything I need.

-- No longer using the extra

LazyVim.on_very_lazy(function()
  vim.filetype.add {
    extension = { mdx = "markdown.mdx" },
  }
end)
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
    "mason-org/mason.nvim",
    ft = { "markdown" },
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "rumdl", "mdslw", "markdownlint-cli2", "markdown-toc" })
      -- vim.list_extend(opts.ensure_installed, { "marksman", "harper-ls" })
    end,
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   ft = { "markdown" },
  --   opts = {
  --     servers = {
  --       harper_ls = {
  --         linters = {
  --           spell_check = false,
  --           spelled_numbers = false,
  --           an_a = true,
  --           sentence_capitalization = true,
  --           unclosed_quotes = true,
  --           wrong_quotes = false,
  --           long_sentences = true,
  --           repeated_words = true,
  --           spaces = true,
  --           matcher = true,
  --           correct_number_suffix = true,
  --           number_suffix_capitalization = true,
  --           multiple_sequential_pronouns = true,
  --           linking_verbs = false,
  --           avoid_curses = true,
  --           terminating_conjunctions = true,
  --         },
  --         codeActions = {
  --           forceStable = true,
  --         },
  --       },
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
  -- {
  --   "mfussenegger/nvim-lint",
  --   opts = {
  --     linters_by_ft = {
  --       markdown = { "markdownlint", "codespell" },
  --     },
  --   },
  -- },
  -- {
  --   "stevearc/conform.nvim",
  --   -- NOTE: For github flavored markdown use this extension: https://github.com/hukkin/mdformat-gfm/
  --   -- pip install mdformat-gfm
  --   -- This will create the executable in /opt/homebrew/bin/mdformat.
  --   -- Running the mdformat binary installed from mason will not have these features!
  --   -- Asked about adding mdformat-gfm in mason-registry:
  --   -- https://github.com/mason-org/mason-registry/pull/2132#issuecomment-1865412278
  --
  --   -- opts = function(opts)
  --   --   local registry_status_ok, mason_registry = pcall(require, "mason-registry")
  --   --   if not registry_status_ok then
  --   --     return
  --   --   end
  --   --
  --   --   mason_registry.refresh(function()
  --   --     local mdformat = mason_registry.get_package "mdformat"
  --   --     local mdformat_extensions = {
  --   --       "mdformat-gfm",
  --   --       -- "mdformat-toc",
  --   --       -- "mdformat-myst",
  --   --     }
  --   --     mdformat:on("install:success", function()
  --   --       -- Create the installation command.
  --   --       vim.notify "Installing mdformat extensions."
  --   --       local extensions = table.concat(mdformat_extensions, " ")
  --   --       local python = mdformat:get_install_path() .. "/venv/bin/python"
  --   --       local pip_cmd = string.format("%s -m pip install %s", python, extensions)
  --   --
  --   --       -- vim.fn.jobstart doesn't work in callback so use popen instead.
  --   --       local handle = io.popen(pip_cmd)
  --   --       if not handle then
  --   --         vim.notify('Could not install "mdformat extensions".', vim.log.levels.ERROR)
  --   --         return
  --   --       end
  --   --       local _ = handle:read "*a"
  --   --       handle:close()
  --   --
  --   --       vim.notify '"mdformat extensions" were successfully installed.'
  --   --     end)
  --   --   end)
  --   --
  --   --   -- vim.list_extend(opts.formatters_by_ft, {
  --   --   --   markdown = { "mdformat" },
  --   --   -- })
  --   --   -- vim.list_extend(opts.formatters, {
  --   --   --   mdformat = {
  --   --   --     prepend_args = { "--number" },
  --   --   --   },
  --   --   -- })
  --   --
  --   --   opts.formatters_by_ft = {
  --   --     markdown = { "mdformat" },
  --   --   }
  --   --   opts.formatters = {
  --   --     mdformat = {
  --   --       prepend_args = { "--number" },
  --   --     },
  --   --   }
  --   -- end,
  --   opts = {
  --     formatters_by_ft = {
  --       markdown = { "mdformat" },
  --     },
  --     formatters = {
  --       mdformat = {
  --         prepend_args = { "--number" },
  --       },
  --     },
  --   },
  -- },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        ["markdown-toc"] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find "<!%-%- toc %-%->" then
                return true
              end
            end
          end,
        },
        ["markdownlint-cli2"] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(function(d)
              return d.source == "markdownlint"
            end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end,
        },
        ["rumdl"] = {
          command = "rumdl",
          args = { "fmt", "-", "--quiet" },
          stdin = true,
        },
      },
      formatters_by_ft = {
        ["markdown"] = { "rumdl", "mdslw", "markdown-toc" },
        ["markdown.mdx"] = { "rumdl", "mdslw", "markdown-toc" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint-cli2" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {},
      },
    },
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      require("lazy").load { plugins = { "markdown-preview.nvim" } }
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd [[do FileType]]
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
      checkbox = {
        enabled = false,
      },
    },
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      Snacks.toggle({
        name = "Render Markdown",
        get = require("render-markdown").get,
        set = require("render-markdown").set,
      }):map "<leader>um"
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      indent = {
        enabled = true,
        skip_heading = true,
      },
    },
  },
}
