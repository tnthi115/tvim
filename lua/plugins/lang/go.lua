if vim.g.vscode then
  return {}
end

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
          -- keys = {
          --   -- Workaround for the lack of a DAP strategy in neotest-go: https://github.com/nvim-neotest/neotest-go/issues/12
          --   { "<leader>td", "<cmd>lua require('dap-go').debug_test()<CR>", desc = "Debug Nearest (Go)" },
          -- },
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
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
      },
      setup = {
        gopls = function(_, opts)
          -- workaround for gopls not supporting semanticTokensProvider
          -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
          Snacks.util.lsp.on({ name = "gopls" }, function(_, client)
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
          end)
          -- end workaround
        end,
      },
    },
  },
  -- Disable golangci_lint_ls server as we use golangci-lint via nvim-lint
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.golangci_lint_ls = { enabled = false }
      opts.setup = opts.setup or {}
      opts.setup.golangci_lint_ls = function()
        return true
      end
    end,
  },
  -- Install mason packages.
  {
    "mason-org/mason.nvim",
    ft = go_filetypes,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "gopls",
        "golangci-lint",
        "gofumpt",
        "goimports",
        "goimports-reviser",
        "golines",
        "gotests",
        "iferr",
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "delve" })
        end,
      },
      {
        "leoluz/nvim-dap-go",
        opts = {},
      },
    },
  },
  -- Setup gomodifytags and impl.
  -- {
  --   "nvimtools/none-ls.nvim",
  --   -- ft = go_filetypes,
  --   dependencies = {
  --     {
  --       "mason-org/mason.nvim",
  --       opts = function(_, opts)
  --         opts.ensure_installed = opts.ensure_installed or {}
  --         vim.list_extend(opts.ensure_installed, { "gomodifytags", "impl" })
  --       end,
  --     },
  --   },
  --   opts = function(_, opts)
  --     -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
  --     local nls = require "null-ls"
  --     -- Remove goimports (added by lazyvim.plugins.extras.lang.go)
  --     -- TODO: this doesn't work
  --     -- opts.sources["nls.builtins.formatting.goimports"] = nil
  --     opts.sources = vim.list_extend(opts.sources or {}, {
  --       nls.builtins.code_actions.gomodifytags,
  --       nls.builtins.code_actions.impl,
  --       -- nls.builtins.formatting.goimports,
  --       -- nls.builtins.formatting.gofmt,
  --     })
  --   end,
  -- },
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      local wk = require "which-key"
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "go" },
        callback = function()
          wk.add {
            "<leader>m",
            mode = { "n", "v" },
            group = "go",
            icon = { icon = require("mini.icons").get("filetype", "go"), color = "azure" },
          }
        end,
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = { ensure_installed = { "golangci-lint" } },
      },
    },
    opts = {
      linters_by_ft = {
        -- uses my ~/.golangci.yml config file
        go = { "golangcilint" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    ft = go_filetypes,
    keys = {
      {
        "<leader>mg",
        mode = { "n", "v" },
        ft = go_filetypes,
        function()
          require("conform").format { formatters = { "golines" } }
        end,
        desc = "Format with golines",
      },
      {
        "<leader>mf",
        mode = { "n", "v" },
        ft = go_filetypes,
        function()
          require("conform").format { formatters = { "gofumpt", "goimports-reviser" } }
        end,
        desc = "Format with gofumpt and goimports-reviser",
      },
    },
    opts = {
      formatters_by_ft = {
        go = function()
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
            -- return { "goimports", "gofmt" }
            return { "goimports" }
          else
            return { "goimports-reviser", "gofumpt", "golines" }
          end
        end,
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    ft = go_filetypes,
    dependencies = {
      -- "nvim-neotest/neotest-go",
      -- neotest-golang
      -- "antoinemadec/FixCursorHold.nvim",
      "fredrikaverpil/neotest-golang",
    },
    opts = {
      adapters = {
        -- ["neotest-go"] = {
        --   -- Here we can set options for neotest-go, e.g.
        --   -- args = { "-tags=integration" }
        --   recursive_run = true,
        -- },
        ["neotest-golang"] = {
          -- Here we can set options for neotest-golang, e.g.
          -- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
          dap_go_enabled = true, -- requires leoluz/nvim-dap-go
        },
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
    keys = {
      { "<leader>mt", ft = go_filetypes, "<cmd>GoMod tidy<CR>", desc = "Tidy" },
      { "<leader>ma", ft = go_filetypes, "<cmd>GoTestAdd<CR>", desc = "Add Test" },
      { "<leader>mA", ft = go_filetypes, "<cmd>GoTestsAll<CR>", desc = "Add All Tests" },
      { "<leader>mE", ft = go_filetypes, "<cmd>GoTestsExp<CR>", desc = "Add Exported Tests" },
      { "<leader>mG", ft = go_filetypes, "<cmd>GoGenerate<CR>", desc = "Go Generate" },
      { "<leader>mF", ft = go_filetypes, "<cmd>GoGenerate %<CR>", desc = "Go Generate File" },
      { "<leader>mc", ft = go_filetypes, "<cmd>GoCmt<CR>", desc = "Generate Comment" },
      { "<leader>me", ft = go_filetypes, "<cmd>GoIfErr<CR>", desc = "Generate iferr" },
      { "<leader>mT", ft = go_filetypes, "<cmd>GoTagAdd proto<CR>", desc = "Add Protobuf Tags" },
      {
        "<leader>md",
        ft = go_filetypes,
        function()
          require("gopher.dap").debug_test()
        end,
        desc = "Debug Go Test",
      },
      { "<leader>mi", ft = go_filetypes, "<cmd>GoImpl<CR>", desc = "Impl" },
    },
    config = function()
      local gopher_ok, gopher = pcall(require, "gopher")
      if not gopher_ok then
        return
      end

      gopher.setup {
        -- log level, you might consider using DEBUG or TRACE for debugging the plugin
        ---@type number
        log_level = vim.log.levels.INFO,

        -- timeout for running internal commands
        ---@type number
        timeout = 2000,

        --- timeout for running installer commands(e.g :GoDepsInstall, :GoDepsInstallSync)
        installer_timeout = 999999,

        -- user specified paths to binaries
        ---@class gopher.ConfigCommand
        commands = {
          go = "go",
          gomodifytags = "gomodifytags",
          gotests = "gotests",
          impl = "impl",
          iferr = "iferr",
        },
        ---@class gopher.ConfigGotests
        gotests = {
          -- gotests doesn't have template named "default" so this plugin uses "default" to set the default template
          template = "default",
          -- path to a directory containing custom test code templates
          ---@type string|nil
          template_dir = nil,
          -- switch table tests from using slice to map (with test name for the key)
          named = false,
        },
        ---@class gopher.ConfigGoTag
        gotag = {
          ---@type gopher.ConfigGoTagTransform
          transform = "snakecase",

          -- default tags to add to struct fields
          default_tag = "json",
        },
        iferr = {
          -- choose a custom error message
          ---@type string|nil
          message = nil,
        },
      }

      -- require("gopher.dap").setup()
    end,
    -- build = function()
    --   vim.cmd [[silent! GoInstallDeps]]
    -- end,
  },
  {
    "quolpr/quicktest.nvim",
    ft = { "go" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- "m00qek/baleia.nvim",
    },
    cmd = { "QuicktestRunLine", "QuicktestRunFile", "QuicktestRunDir", "QuicktestrunAll" },
    keys = {
      {
        "<leader>tR",
        ft = { "go" },
        function()
          require("quicktest").run_line()
        end,
        desc = "Run Nearest (Quicktest)",
      },
      {
        "<leader>tL",
        ft = { "go" },
        function()
          require("quicktest").run_previous()
        end,
        desc = "Run Last (Quicktest)",
      },
      {
        "<leader>tu",
        ft = { "go" },
        function()
          require("quicktest").toggle_win "split"
        end,
        desc = "Toggle Window (Quicktest)",
      },
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("quicktest").setup {
        adapters = {
          require "quicktest.adapters.golang",
        },
        -- split or popup mode, when argument not specified
        default_win_mode = "split",
        -- Baleia make coloured output. Requires baleia package. Can cause crashes https://github.com/quolpr/quicktest.nvim/issues/11
        use_baleia = false,
      }
    end,
  },
  {
    "benmills/vimux-golang",
    ft = { "go" },
    dependencies = {
      "preservim/vimux",
    },
    cmd = { "GolangTestCurrentPackage", "GolangTestFocused" },
    keys = {
      { "<leader>tf", ft = { "go" }, "<cmd>GolangTestFocused<CR>", desc = "Test Focused (vimux-golang)" },
    },
  },
  -- Filetype icons
  {
    "nvim-mini/mini.icons",
    opts = {
      file = {
        [".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
      },
      filetype = {
        gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
      },
    },
  },
  -- This doesn't work unfortunately
  -- use https://github.com/Bparsons0904/phantom-err.nvim instead
  -- {
  --   "Snyssfx/goerr-nvim",
  --   ft = { "go" },
  --   config = function()
  --     vim.cmd [[syntax on]]
  --     vim.opt.foldmethod = "syntax"
  --     vim.opt.foldnestmax = 10
  --     vim.opt.foldlevel = 9
  --     vim.opt.softtabstop = 2
  --   end,
  -- },
  {
    "maxandron/goplements.nvim",
    ft = "go",
    cmd = { "GoplementEnable", "GoplementDisable", "GoplementToggle" },
    keys = {
      { "<leader>mu", ft = go_filetypes, "", desc = "ui/toggles" },
      { "<leader>mug", ft = go_filetypes, "<cmd>GoplementToggle<CR>", desc = "Toggle Goplements" },
    },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      -- Whether to display the package name along with the type name (i.e., builtins.error vs error)
      display_package = false,
      -- The default links to DiagnosticHint
      highlight = "LspInlayHint",
    },
  },
}
