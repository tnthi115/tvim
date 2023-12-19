-- Full spec: https://www.lazyvim.org/extras/lang/go

local go_filetypes = { "go", "gomod", "gowork", "gosum" }

return {
  -- Install treesitter parsers.
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   ft = go_filetypes,
  --   opts = function(_, opts)
  --     vim.list_extend(opts.ensure_installed, go_filetypes)
  --   end,
  -- },
  -- Setup gopls and golangci_lint_ls.
  {
    "neovim/nvim-lspconfig",
    ft = go_filetypes,
    opts = {
      servers = {
        gopls = {
          keys = {
            -- Workaround for the lack of a DAP strategy in neotest-go: https://github.com/nvim-neotest/neotest-go/issues/12
            { "<leader>td", "<cmd>lua require('dap-go').debug_test()<CR>", desc = "Debug Nearest (Go)" },
          },
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = true,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          },
        },
        golangci_lint_ls = {
          init_options = {
            command = {
              "golangci-lint",
              "run",
              "--enable-all",
              "--disable",
              -- "deadcode,exhaustivestruct,gci,gofmt,gofumpt,goimports,golint,ifshort,interfacer,lll,maligned,misspell,nlreturn,nonamedreturns,nosnakecase,revive,scopelint,structcheck,tagalign,tagliatelle,varcheck,varnamelen,whitespace,wsl",
              -- "deadcode,depguard,exhaustivestruct,gci,gofmt,golint,ifshort,interfacer,lll,maligned,misspell,nlreturn,nonamedreturns,nosnakecase,revive,scopelint,structcheck,tagalign,tagliatelle,varcheck,whitespace,wsl",
              -- "deadcode,depguard,exhaustivestruct,gci,gofmt,ifshort,interfacer,lll,maligned,misspell,nlreturn,nonamedreturns,nosnakecase,scopelint,structcheck,tagalign,tagliatelle,varcheck,whitespace,wsl",
              "deadcode,depguard,exhaustivestruct,gci,gofmt,golint,interfacer,lll,maligned,misspell,nlreturn,nonamedreturns,nosnakecase,scopelint,structcheck,tagalign,tagliatelle,varcheck,whitespace,wsl",
              "--out-format",
              "json",
              "--issues-exit-code=1",
              -- "--go=1.18",
            },
          },
        },
      },
      -- setup = {
      --   gopls = function(_, opts)
      --     -- workaround for gopls not supporting semanticTokensProvider
      --     -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
      --     require("lazyvim.util").lsp.on_attach(function(client, _)
      --       if client.name == "gopls" then
      --         if not client.server_capabilities.semanticTokensProvider then
      --           local semantic = client.config.capabilities.textDocument.semanticTokens
      --           client.server_capabilities.semanticTokensProvider = {
      --             full = true,
      --             legend = {
      --               tokenTypes = semantic.tokenTypes,
      --               tokenModifiers = semantic.tokenModifiers,
      --             },
      --             range = true,
      --           }
      --         end
      --       end
      --     end)
      --     -- end workaround
      --   end,
      -- },
    },
  },
  -- Install mason packages.
  {
    "williamboman/mason.nvim",
    ft = go_filetypes,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- "gopls",
        -- "golangci-lint",
        "golangci-lint-langserver",
        -- "gofumpt",
        -- "goimports-reviser",
        -- "gomodifytags",
        -- "gotests",
        -- "impl",
        -- "iferr",
        -- "delve",
      })
      opts.ensure_installed["goimports"] = nil
    end,
  },
  -- Setup nvim-dap-go.
  -- {
  --   "leoluz/nvim-dap-go",
  --   ft = go_filetypes,
  --   config = true,
  -- },
  -- {
  --   "mfussenegger/nvim-dap",
  --   optional = true,
  --   dependencies = {
  --     -- {
  --     --   "williamboman/mason.nvim",
  --     --   opts = function(_, opts)
  --     --     opts.ensure_installed = opts.ensure_installed or {}
  --     --     vim.list_extend(opts.ensure_installed, { "delve" })
  --     --   end,
  --     -- },
  --     {
  --       "leoluz/nvim-dap-go",
  --       config = true,
  --     },
  --   },
  -- },
  -- Setup gofumpt, goimports-reviser, gomodifytags, and impl.
  {
    "nvimtools/none-ls.nvim",
    ft = go_filetypes,
    -- dependencies = {
    --   {
    --     "williamboman/mason.nvim",
    --     opts = function(_, opts)
    --       opts.ensure_installed = opts.ensure_installed or {}
    --       vim.list_extend(opts.ensure_installed, { "gomodifytags", "impl" })
    --     end,
    --   },
    -- },
    opts = function(_, opts)
      -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
      local nls = require "null-ls"
      -- Remove goimports (added by lazyvim.plugins.extras.lang.go)
      opts.sources["nls.builtins.formatting.goimports"] = nil
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.code_actions.gomodifytags,
        nls.builtins.code_actions.impl,
        nls.builtins.formatting.goimports_reviser.with {
          extra_args = { "-company-prefixes=gopkg.volterra.us", "-set-alias", "-use-cache" },
        },
        nls.builtins.formatting.gofumpt,
      })
      -- opts.sources = {
      --   nls.builtins.code_actions.gomodifytags,
      --   nls.builtins.code_actions.impl,
      --   nls.builtins.formatting.goimports_reviser.with {
      --     extra_args = { "-company-prefixes=gopkg.volterra.us", "-set-alias", "-use-cache" },
      --   },
      --   nls.builtins.formatting.gofumpt,
      -- }
    end,
  },
  -- {
  --   "stevearc/conform.nvim",
  --   ft = go_filetypes,
  --   opts = function(_, opts)
  --     opts.formatters_by_ft = {
  --       go = { "goimports-reviser", "gofumpt" },
  --     }
  --     opts.formatters = {
  --       goimports_reviser = {
  --         args = { "-company-prefixes=gopkg.volterra.us", "-set-alias", "-use-cache" },
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   "nvim-neotest/neotest",
  --   ft = go_filetypes,
  --   dependencies = {
  --     "nvim-neotest/neotest-go",
  --   },
  --   opts = {
  --     adapters = {
  --       ["neotest-go"] = {
  --         -- Here we can set options for neotest-go, e.g.
  --         -- args = { "-tags=integration" }
  --       },
  --     },
  --   },
  -- },
  -- gopher.nvim plugin
  {
    "olexsmir/gopher.nvim",
    ft = go_filetypes,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local gopher_ok, gopher = pcall(require, "gopher")
      if not gopher_ok then
        return
      end

      gopher.setup {
        commands = {
          go = "go",
          gomodifytags = "gomodifytags",
          gotests = "gotests",
          impl = "impl",
          iferr = "iferr",
          dlv = "dlv",
        },
      }

      require("gopher.dap").setup()

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "go" },
        callback = function()
          local which_key_ok, which_key = pcall(require, "which-key")
          if not which_key_ok then
            return
          end

          local opts = {
            mode = "n", -- NORMAL mode
            prefix = "<leader>",
            -- buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
            buffer = vim.api.nvim_get_current_buf(), -- Local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true, -- use `nowait` when creating keymaps
          }

          local mappings = {
            j = {
              name = "Go",
              t = { "<cmd>GoMod tidy<cr>", "Tidy" },
              a = { "<cmd>GoTestAdd<Cr>", "Add Test" },
              A = { "<cmd>GoTestsAll<Cr>", "Add All Tests" },
              E = { "<cmd>GoTestsExp<Cr>", "Add Exported Tests" },
              g = { "<cmd>GoGenerate<Cr>", "Go Generate" },
              f = { "<cmd>GoGenerate %<Cr>", "Go Generate File" },
              c = { "<cmd>GoCmt<Cr>", "Generate Comment" },
              e = { "<cmd>GoIfErr<Cr>", "Generate iferr" },
              T = { "<cmd>GoTagAdd<Cr>", "Add Tags" },
              d = { "<cmd>lua require('dap-go').debug_test()<cr>", "Debug Go Test" },
            },
          }

          which_key.register(mappings, opts)
        end,
      })
    end,
    -- build = function()
    --   vim.cmd [[silent! GoInstallDeps]]
    -- end,
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    ft = go_filetypes,
    opts = {
      debug_mode = true,
    },
    keys = {
      { "<leader>uh", "<cmd>lua require('lsp-inlayhints').toggle()<CR>", desc = "Toggle Inlay Hints" },
    },
    config = function(_, options)
      vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
      vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_inlayhints",
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end

          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, bufnr)
        end,
      })
      options.inlay_hints = {
        highlight = "LspCodeLens",
      }
      require("lsp-inlayhints").setup(options)
    end,
  },
}
