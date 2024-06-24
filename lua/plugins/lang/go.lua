-- Full spec: https://www.lazyvim.org/extras/lang/go
-- I am no longer importing lazyvim.plugins.extras.lang.go, but instead using
-- it as a foundation.

local go_filetypes = { "go", "gomod", "gowork", "gosum" }

return {
  -- Install treesitter parsers.
  {
    "nvim-treesitter/nvim-treesitter",
    ft = go_filetypes,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, go_filetypes)
    end,
  },
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
                -- fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
                shadow = true,
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
              -- "--enable-all",
              -- "--disable",
              -- "deadcode,exhaustivestruct,gci,gofmt,gofumpt,goimports,golint,ifshort,interfacer,lll,maligned,misspell,nlreturn,nonamedreturns,nosnakecase,revive,scopelint,structcheck,tagalign,tagliatelle,varcheck,varnamelen,whitespace,wsl",
              -- "deadcode,depguard,exhaustivestruct,gci,gofmt,golint,ifshort,interfacer,lll,maligned,misspell,nlreturn,nonamedreturns,nosnakecase,revive,scopelint,structcheck,tagalign,tagliatelle,varcheck,whitespace,wsl",
              -- "deadcode,depguard,exhaustivestruct,gci,gofmt,ifshort,interfacer,lll,maligned,misspell,nlreturn,nonamedreturns,nosnakecase,scopelint,structcheck,tagalign,tagliatelle,varcheck,whitespace,wsl",
              -- "deadcode,depguard,exhaustivestruct,gci,gofmt,golint,interfacer,lll,maligned,misspell,nlreturn,nonamedreturns,nosnakecase,scopelint,structcheck,tagalign,tagliatelle,varcheck,whitespace,wsl",
              -- "deadcode,depguard,exhaustivestruct,gci,gofmt,gofumpt,golint,interfacer,maligned,misspell,nlreturn,nonamedreturns,nosnakecase,scopelint,structcheck,tagalign,tagliatelle,varcheck,whitespace,wsl",
              "--disable-all",
              "--enable",
              "errcheck,gosimple,govet,ineffassign,staticcheck,typecheck,unused,asasalint,asciicheck,bidichk,bodyclose,cyclop,decorder,dupl,durationcheck,errname,errorlint,execinquery,exhaustive,exhaustruct,exportloopref,forbidigo,funlen,gocheckcompilerdirectives,gochecknoglobals,gochecknoinits,gochecksumtype,gocognit,goconst,gocritic,gocyclo,godot,goimports,gomnd,gomoddirectives,gomodguard,goprintffuncname,gosec,ireturn,lll,loggercheck,makezero,mirror,musttag,nakedret,nestif,nilerr,nilnil,noctx,nolintlint,nonamedreturns,nosprintfhostport,perfsprint,prealloc,predeclared,promlinter,protogetter,reassign,revive,rowserrcheck,sloglint,sqlclosecheck,stylecheck,tenv,testableexamples,testifylint,testpackage,tparallel,unconvert,unparam,usestdlibvars,wastedassign,whitespace,wrapcheck",
              "--out-format",
              "json",
              "--issues-exit-code=1",
              -- "--go=1.18",
            },
          },
        },
      },
      setup = {
        gopls = function(_, opts)
          -- workaround for gopls not supporting semanticTokensProvider
          -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
          require("lazyvim.util").lsp.on_attach(function(client, _)
            if client.name == "gopls" then
              if not client.server_capabilities.semanticTokensProvider then
                local semantic = client.config.capabilities.textDocument.semanticTokens
                client.server_capabilities.semanticTokensProvider = {
                  full = true,
                  legend = {
                    tokenTypes = semantic.tokenTypes,
                    tokenModifiers = semantic.tokenModifiers,
                  },
                  range = true,
                }
              end
            end
          end)
          -- end workaround
        end,
      },
    },
  },
  -- Install mason packages.
  {
    "williamboman/mason.nvim",
    ft = go_filetypes,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "gopls",
        "golangci-lint",
        "golangci-lint-langserver",
        "gofumpt",
        "goimports-reviser",
        "golines",
        "gomodifytags",
        "gotests",
        "impl",
        "iferr",
        "delve",
      })
    end,
  },
  -- Setup nvim-dap-go.
  -- {
  --   "leoluz/nvim-dap-go",
  --   ft = go_filetypes,
  --   config = true,
  -- },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "delve" })
        end,
      },
      {
        "leoluz/nvim-dap-go",
        config = true,
      },
    },
  },
  -- Setup gofumpt, goimports-reviser, gomodifytags, and impl.
  {
    "nvimtools/none-ls.nvim",
    -- ft = go_filetypes,
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
      -- TODO: this doesn't work
      -- opts.sources["nls.builtins.formatting.goimports"] = nil
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.code_actions.gomodifytags,
        nls.builtins.code_actions.impl,
        -- nls.builtins.formatting.goimports,
        -- nls.builtins.formatting.gofmt,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    ft = go_filetypes,
    opts = {
      formatters_by_ft = {
        -- go = { "goimports", "gofmt" },
        go = function()
          local which_key_ok, which_key = pcall(require, "which-key")
          if which_key_ok then
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
                name = "+go",
                g = {
                  mode = { "n", "v" },
                  "<cmd>lua require('conform').format({formatters = {'golines'}})<CR>",
                  "Format with golines",
                },
                f = {
                  mode = { "n", "v" },
                  "<cmd>lua require('conform').format({formatters = {'gofumpt', 'goimports-reviser'}})<CR>",
                  "Format with gofumpt and goimports-reviser",
                },
              },
            }

            which_key.register(mappings, opts)
          end

          local current_dir = vim.fn.expand "%:p:h"
          local target_dir = vim.fn.glob "$HOME/go/src/*"
          local is_in_work_dir = false
          while current_dir ~= vim.fn.glob "$HOME" do
            if current_dir == target_dir then
              is_in_work_dir = true
              break
            end
            current_dir = vim.fn.fnamemodify(current_dir, ":h")
          end

          if is_in_work_dir then
            return { "goimports", "gofmt" }
          else
            return { "goimports-reviser", "gofumpt", "golines" }
          end
        end,
      },
    },
  },
  {
    "nvim-neotest/neotest",
    ft = go_filetypes,
    dependencies = {
      "nvim-neotest/neotest-go",
      -- neotest-golang
      -- "antoinemadec/FixCursorHold.nvim",
      -- "fredrikaverpil/neotest-golang",
    },
    opts = {
      adapters = {
        ["neotest-go"] = {
          -- Here we can set options for neotest-go, e.g.
          -- args = { "-tags=integration" }
          recursive_run = true,
        },
        -- ["neotest-golang"] = {},
      },
    },
  },
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
              t = { "<cmd>GoMod tidy<CR>", "Tidy" },
              a = { "<cmd>GoTestAdd<CR>", "Add Test" },
              A = { "<cmd>GoTestsAll<CR>", "Add All Tests" },
              E = { "<cmd>GoTestsExp<CR>", "Add Exported Tests" },
              G = { "<cmd>GoGenerate<CR>", "Go Generate" },
              F = { "<cmd>GoGenerate %<CR>", "Go Generate File" },
              c = { "<cmd>GoCmt<CR>", "Generate Comment" },
              e = { "<cmd>GoIfErr<CR>", "Generate iferr" },
              T = { "<cmd>GoTagAdd proto<CR>", "Add Protobuf Tags" },
              d = { "<cmd>lua require('dap-go').debug_test()<CR>", "Debug Go Test" },
              i = { "<cmd>GoImpl<CR>", "Impl" },
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
}
