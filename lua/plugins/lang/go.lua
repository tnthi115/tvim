if vim.g.vscode then
  return {}
end

-- Full spec: https://www.lazyvim.org/extras/lang/go
-- Using lazyvim.plugins.extras.lang.go as the base via LazyExtras
-- This file only adds overrides and extra plugins for Go.

local go_filetypes = { "go", "gomod", "gowork", "gosum" }

return {
  {
    "folke/which-key.nvim",
    opts = function(_, _)
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
  -- Disable golangci_lint_ls since we use nvim-lint for golangci-lint
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
  {
    "mason-org/mason.nvim",
    ft = go_filetypes,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "goimports-reviser",
        "golines",
        "gotests",
        "iferr",
      })
    end,
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
            return { "goimports" }
          else
            return { "goimports-reviser", "gofumpt", "golines" }
          end
        end,
      },
    },
  },
  -- gopher.nvim plugin (extra commands for tests, tags, impl, iferr, etc.)
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
      local ok, gopher = pcall(require, "gopher")
      if not ok then
        return
      end

      ---@diagnostic disable-next-line: missing-fields
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
  -- quicktest.nvim for lightweight test runs
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
  -- Vimux integration for focused Go tests
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
  -- Inline type info toggles
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
