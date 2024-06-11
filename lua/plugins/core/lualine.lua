-- Full spec: https://www.lazyvim.org/plugins/ui#lualinenvim

local Util = require "lazyvim.util"

local colors = {
  bg = "#202328",
  fg = "#bbc2cf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  purple = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
}

-- @source: https://gist.github.com/Lamarcke/36e086dd3bb2cebc593d505e2f838e07
-- Returns a string with a list of attached LSP clients, including
-- formatters and linters from null-ls, nvim-lint and conform.nvim

local function get_attached_clients()
  local buf_clients = vim.lsp.get_active_clients { bufnr = 0 }
  if #buf_clients == 0 then
    return "LSP Inactive"
  end

  local buf_ft = vim.bo.filetype
  local buf_client_names = {}

  -- add client
  for _, client in pairs(buf_clients) do
    if client.name ~= "copilot" and client.name ~= "null-ls" then
      table.insert(buf_client_names, client.name)
    end
  end

  -- Generally, you should use either null-ls or nvim-lint + conform.nvim, not both.

  -- Add sources (from null-ls)
  -- null-ls registers each source as a separate attached client, so we need to filter for unique names down below.
  -- TODO: when not using null-ls (none-ls), this causes the list to be empty for some reason
  local null_ls_s, null_ls = pcall(require, "null-ls")
  if null_ls_s then
    local sources = null_ls.get_sources()
    for _, source in ipairs(sources) do
      if source._validated then
        for ft_name, ft_active in pairs(source.filetypes) do
          if ft_name == buf_ft and ft_active then
            table.insert(buf_client_names, source.name)
          end
        end
      end
    end
  end

  -- Add linters (from nvim-lint)
  local lint_s, lint = pcall(require, "lint")
  if lint_s then
    for ft_k, ft_v in pairs(lint.linters_by_ft) do
      if type(ft_v) == "table" then
        for _, linter in ipairs(ft_v) do
          if buf_ft == ft_k then
            table.insert(buf_client_names, linter)
          end
        end
      elseif type(ft_v) == "string" then
        if buf_ft == ft_k then
          table.insert(buf_client_names, ft_v)
        end
      end
    end
  end

  -- -- Add formatters (from formatter.nvim)
  -- local formatter_s, _ = pcall(require, "formatter")
  -- if formatter_s then
  --   local formatter_util = require "formatter.util"
  --   for _, formatter in ipairs(formatter_util.get_available_formatters_for_ft(buf_ft)) do
  --     if formatter then
  --       table.insert(buf_client_names, formatter)
  --     end
  --   end
  -- end

  -- Add formatters (from conform.nvim)
  -- lua vim.print(require("conform").list_formatters(vim.api.nvim_get_current_buf()))
  local formatter_s, formatters = pcall(require, "conform")
  if formatter_s then
    for _, formatter in ipairs(formatters.list_formatters(vim.api.nvim_get_current_buf())) do
      if formatter then
        table.insert(buf_client_names, formatter.name)
      end
    end
  end

  -- This needs to be a string only table so we can use concat below
  local unique_client_names = {}
  for _, client_name_target in ipairs(buf_client_names) do
    local is_duplicate = false
    for _, client_name_compare in ipairs(unique_client_names) do
      if client_name_target == client_name_compare then
        is_duplicate = true
      end
    end
    if not is_duplicate then
      table.insert(unique_client_names, client_name_target)
    end
  end

  local client_names_str = table.concat(unique_client_names, ", ")
  local language_servers = string.format("[%s]", client_names_str)

  return language_servers
end

return {
  -- or you can return new options to override all the defaults
  {
    "nvim-lualine/lualine.nvim",
    -- dependencies = {
    --   "dokwork/lualine-ex",
    -- },
    event = "VeryLazy",
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require "lualine_require"
      lualine_require.require = require

      local icons = require("lazyvim.config").icons

      vim.o.laststatus = vim.g.lualine_laststatus

      local attached_clients = {
        get_attached_clients,
        color = {
          gui = "bold",
        },
      }

      return {
        options = {
          theme = "auto",
          globalstatus = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        },
        sections = {
          lualine_a = {
            {
              -- mode
              function()
                -- return " " .. "󰀘" .. " "
                -- return " " .. "" .. " "
                return " " .. "💤" .. " "
                -- return " " .. "󰒲" .. " "
              end,
              padding = { left = 0, right = 0 },
              color = {},
              cond = nil,
            },
            -- nvim-remote
            {
              function()
                -- return vim.g.remote_neovim_host and ("Remote: %s"):format(vim.uv.os_gethostname()) or ""
                return vim.g.remote_neovim_host and ("SSH: %s"):format(vim.uv.os_gethostname()) or ""
              end,
              padding = { right = 1, left = 1 },
              separator = { left = "", right = "" },
            },
          },
          lualine_b = {
            "branch",
            -- {
            --   -- branch
            --   "b:gitsigns_head",
            --   -- TODO: need lunar.nvim theme
            --   icon = "%#SLGitIcon#" .. "" .. "%*" .. "%#SLBranchName#",
            --   -- icon = "%#ff9e64" .. "" .. "%*" .. "%#a9b1d6",
            --   color = { gui = "bold" },
            -- },
            -- {
            --   "ex.git.branch",
            --   -- icon = "",
            --   icon = "",
            -- },
          },
          lualine_c = {
            Util.lualine.root_dir(),
            {
              "diff",
              symbols = {
                -- added = icons.git.added,
                -- modified = icons.git.modified,
                -- removed = icons.git.removed,
                added = " ",
                modified = " ",
                removed = " ",
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
              diff_color = {
                added = { fg = colors.green },
                modified = { fg = colors.yellow },
                removed = { fg = colors.red },
              },
              padding = { left = 2, right = 1 },
            },
            -- { "filetype", icon_only = false, separator = "", padding = { left = 1, right = 0 } },
            -- { Util.lualine.pretty_path() },
          },
          lualine_x = {
            {
              function()
                return require("noice").api.status.command.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.command.has()
              end,
              color = Util.ui.fg "Statement",
            },
            {
              function()
                return require("noice").api.status.mode.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.mode.has()
              end,
              color = Util.ui.fg "Constant",
            },
            {
              function()
                return "  " .. require("dap").status()
              end,
              cond = function()
                return package.loaded["dap"] and require("dap").status() ~= ""
              end,
              color = Util.ui.fg "Debug",
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = Util.ui.fg "Special",
            },
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            -- new component added as per my request: https://github.com/dokwork/lualine-ex/issues/25
            -- {
            --   "ex.lsp.null_ls",
            --
            --   -- The table or function that returns the table with the source query.
            --   -- By default it shows only actual sorces. To show all registered sources
            --   -- you can use just empty table:
            --   query = {},
            --   -- query = function()
            --   --   return { filetype = vim.bo.filetype }
            --   -- end,
            --
            --   -- The string separator between names
            --   source_names_separator = ",",
            --
            --   -- The color for the disabled component:
            --   disabled_color = { fg = "grey" },
            --
            --   -- The color for the icon of the disabled component:
            --   disabled_icon_color = { fg = "grey" },
            -- },
            -- lsps, linters, formatters
            attached_clients,
            -- {
            --   "ex.lsp.all",
            --   only_attached = true,
            -- },
            {
              -- spaces stolen from Lunarvim
              function()
                local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
                return "󰌒" .. " " .. shiftwidth
              end,
              padding = 1,
            },
            { "filetype", icon_only = false, separator = "", padding = { left = 1, right = 2 } },
          },
          lualine_y = {
            { "location" },
          },
          lualine_z = {
            -- function()
            --   return " " .. os.date "%R"
            -- end,
            -- { "progress", separator = " ", padding = { left = 1, right = 1 } },
            {
              "progress",
              fmt = function()
                return "%P/%L"
              end,
              color = {},
            },
          },
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },
}
