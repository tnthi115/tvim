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
  -- {
  --   "davidsierradz/cmp-conventionalcommits",
  --   optional = true,
  --   ft = { "gitcommit", "NeogitCommitMessage" },
  --   dependencies = "hrsh7th/nvim-cmp",
  --   config = function()
  --     require("cmp").setup.buffer {
  --       sources = require("cmp").config.sources({ { name = "conventionalcommits" } }, { { name = "buffer" } }),
  --     }
  --   end,
  -- },
  -- {
  --   "saghen/blink.cmp",
  --   optional = true,
  --   dependencies = {
  --     "davidsierradz/cmp-conventionalcommits",
  --     "saghen/blink.compat",
  --   },
  --   opts = {
  --     sources = {
  --       compat = { "conventionalcommits" },
  --       providers = {
  --         conventionalcommits = {
  --           kind = "ConventionalCommits",
  --           score_offset = 100,
  --           async = true,
  --         },
  --       },
  --     },
  --   },
  -- },
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = {
      { "disrupted/blink-cmp-conventional-commits" },
    },
    opts = {
      sources = {
        default = {
          "conventional_commits", -- add it to the list
        },
        providers = {
          conventional_commits = {
            name = "Conventional Commits",
            module = "blink-cmp-conventional-commits",
            enabled = function()
              return vim.bo.filetype == "gitcommit"
            end,
            ---@module 'blink-cmp-conventional-commits'
            ---@type blink-cmp-conventional-commits.Options
            opts = {}, -- none so far
          },
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = {
      {
        "Kaiser-Yang/blink-cmp-git",
        -- ft = { "gitcommit", "NeogitCommitMessage", "markdown" },
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    opts = {
      sources = {
        -- add 'git' to the list
        default = { "git" },
        providers = {
          git = {
            module = "blink-cmp-git",
            name = "Git",
            -- only enable this source when filetype is gitcommit, markdown, or 'octo'
            enabled = function()
              return vim.tbl_contains({ "octo", "gitcommit", "markdown", "NeogitCommitMessage" }, vim.bo.filetype)
            end,
            --- @module 'blink-cmp-git'
            --- @type blink-cmp-git.Options
            opts = {
              -- options for the blink-cmp-git
              -- commit = {
              -- You may want to customize when it should be enabled
              -- The default will enable this when `git` is found and `cwd` is in a git repository
              -- enable = function() end
              -- You may want to change the triggers
              -- triggers = { ':' },
              -- },
              git_centers = {
                github = {
                  -- Those below have the same fields with `commit`
                  -- Those features will be enabled when `git` and `gh` (or `curl`) are found and
                  -- remote contains `github.com`
                  issue = {
                    get_token = function()
                      return vim.env.GITHUB_TOKEN
                    end,
                  },
                  pull_request = {
                    get_token = function()
                      return vim.env.GITHUB_TOKEN
                    end,
                  },
                  mention = {
                    get_token = function()
                      return vim.env.GITHUB_TOKEN
                    end,
                    get_documentation = function(item)
                      local default = require("blink-cmp-git.default.github").mention.get_documentation(item)
                      default.get_token = function()
                        return vim.env.GITHUB_TOKEN
                      end
                      return default
                    end,
                    get_documentation = function(item)
                      local default = require("blink-cmp-git.default.github").mention.get_documentation(item)
                      default.get_token = function()
                        return vim.env.GITHUB_TOKEN
                      end
                      return default
                    end,
                  },
                },
                gitlab = {
                  -- Those below have the same fields with `commit`
                  -- Those features will be enabled when `git` and `glab` (or `curl`) are found and
                  -- remote contains `gitlab.com`
                  issue = {
                    get_token = function()
                      return vim.env.GITLAB_TOKEN
                    end,
                    triggers = { "#" },
                  },
                  -- NOTE:
                  -- Even for `gitlab`, you should use `pull_request` rather than `merge_request`
                  pull_request = {
                    get_token = function()
                      return vim.env.GITLAB_TOKEN
                    end,
                  },
                  mention = {
                    get_token = function()
                      return vim.env.GITLAB_TOKEN
                    end,
                    get_documentation = function(item)
                      local default = require("blink-cmp-git.default.gitlab").mention.get_documentation(item)
                      default.get_token = function()
                        return vim.env.GITLAB_TOKEN
                      end
                      return default
                    end,
                  },
                },
              },
            },
          },
        },
      },
    },
  },
}
