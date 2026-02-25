-- Full spec: https://www.lazyvim.org/plugins/ui#lualinenvim

-- local colors = {
--   bg = "#202328",
--   fg = "#bbc2cf",
--   yellow = "#ECBE7B",
--   cyan = "#008080",
--   darkblue = "#081633",
--   green = "#98be65",
--   orange = "#FF8800",
--   violet = "#a9a1e1",
--   magenta = "#c678dd",
--   purple = "#c678dd",
--   blue = "#51afef",
--   red = "#ec5f67",
-- }

-- @source: https://gist.github.com/Lamarcke/36e086dd3bb2cebc593d505e2f838e07
-- Returns a string with a list of attached LSP clients, including
-- formatters and linters from null-ls, nvim-lint and conform.nvim

local function get_attached_clients()
  local buf_clients = vim.lsp.get_clients { bufnr = 0 }
  if #buf_clients == 0 then
    return "LSP Inactive"
  end

  local buf_ft = vim.bo.filetype
  local lsp_clients = {}
  local linters = {}
  local formatters = {}

  -- Add LSP clients
  for _, client in pairs(buf_clients) do
    if client.name ~= "copilot" and client.name ~= "null-ls" then
      table.insert(lsp_clients, client.name)
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
            -- Categorize null-ls sources as either formatters or linters based on their methods
            if source.methods then
              if vim.tbl_contains(source.methods, require("null-ls").methods.FORMATTING) then
                table.insert(formatters, source.name)
              elseif vim.tbl_contains(source.methods, require("null-ls").methods.DIAGNOSTICS) then
                table.insert(linters, source.name)
              end
            else
              -- If we can't determine, treat as generic LSP client
              table.insert(lsp_clients, source.name)
            end
          end
        end
      end
    end
  end

  -- Add linters (from nvim-lint)
  local lint_s, lint = pcall(require, "lint")
  if lint_s then
    for ft_k, ft_v in pairs(lint.linters_by_ft) do
      if ft_k == buf_ft then
        if type(ft_v) == "table" then
          for _, linter in ipairs(ft_v) do
            table.insert(linters, linter)
          end
        elseif type(ft_v) == "string" then
          table.insert(linters, ft_v)
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
  --       table.insert(formatters, formatter)
  --     end
  --   end
  -- end

  -- Add formatters (from conform.nvim)
  -- lua vim.print(require("conform").list_formatters(vim.api.nvim_get_current_buf()))
  local formatter_s, conform = pcall(require, "conform")
  if formatter_s then
    for _, formatter in ipairs(conform.list_formatters(vim.api.nvim_get_current_buf())) do
      if formatter then
        table.insert(formatters, formatter.name)
      end
    end
  end

  -- Remove duplicates from each category
  local function deduplicate(list)
    local unique = {}
    local result = {}
    for _, item in ipairs(list) do
      if not unique[item] then
        unique[item] = true
        table.insert(result, item)
      end
    end
    return result
  end

  local unique_lsp_clients = deduplicate(lsp_clients)
  local unique_linters = deduplicate(linters)
  local unique_formatters = deduplicate(formatters)

  -- Combine all categories with their respective icons in a single bracket
  local all_tools = {}

  local icons = {
    lsp_clients = { "󰒋 ", " " },
    linters = { "󰁨 ", " " },
    formatters = { "󰉿 ", "󰊅 " },
  }

  if #unique_lsp_clients > 0 then
    table.insert(all_tools, icons.lsp_clients[2] .. table.concat(unique_lsp_clients, ", "))
  end

  if #unique_linters > 0 then
    table.insert(all_tools, icons.linters[2] .. table.concat(unique_linters, ", "))
  end

  if #unique_formatters > 0 then
    table.insert(all_tools, icons.formatters[2] .. table.concat(unique_formatters, ", "))
  end

  if #all_tools == 0 then
    -- return "No Tools"
    return "LSP Inactive"
  end

  -- return "[ " .. table.concat(all_tools, " ") .. " ]"
  return table.concat(all_tools, " ")
end

return {
  -- or you can return new options to override all the defaults
  {
    "nvim-lualine/lualine.nvim",
    -- dependencies = {
    --   "dokwork/lualine-ex",
    -- },
    event = "VeryLazy",
    opts = function(_, opts)
      -- TODO: add this config to debugmaster.lua
      -- source: https://github.com/miroshQa/dotfiles/blob/2cb9dc3368b1ac0982f26af724db8eac073ba55c/nvim/lua/plugins/lualine.lua#L25C1-L47C1
      local dmode_enabled = false
      vim.api.nvim_create_autocmd("User", {
        pattern = "DebugModeChanged",
        callback = function(args)
          dmode_enabled = args.data.enabled
        end,
      })

      local icons = LazyVim.config.icons

      local attached_clients = {
        get_attached_clients,
        color = {
          gui = "bold",
        },
      }

      opts.options = {
        theme = "auto",
        globalstatus = vim.o.laststatus == 3,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
      }
      opts.sections.lualine_a = {
        {
          -- mode
          function()
            -- return " " .. "󰀘" .. " "
            -- return " " .. "" .. " "
            return " " .. "💤" .. " "
            -- return " " .. "󰒲" .. " "
          end,
          padding = { left = 0, right = 0 },
          -- color = {},
          -- TODO: add this config to debugmaster.lua
          color = function(tb)
            return dmode_enabled and "dCursor" or tb
          end,
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
      }
      opts.sections.lualine_c = {
        require("lazyvim.util").lualine.root_dir(),
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { LazyVim.lualine.pretty_path(), padding = { left = 0, right = 0 } },
        {
          "diff",
          symbols = {
            added = icons.git.added,
            modified = icons.git.modified,
            removed = icons.git.removed,
            -- added = " ",
            -- modified = " ",
            -- removed = " ",
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
          -- diff_color = {
          --   added = { fg = colors.green },
          --   modified = { fg = colors.yellow },
          --   removed = { fg = colors.red },
          -- },
          padding = { left = 2, right = 1 },
        },
      }
      -- Remove diff section in LazyVim config: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/ui.lua?plain=1#L168-L185
      table.remove(opts.sections.lualine_x)
      -- Insert opencode statusline before copilot (which is at position 2)
      table.insert(opts.sections.lualine_x, 1, {
        require("opencode").statusline,
        padding = 2,
        cond = function()
          return package.loaded["opencode"] ~= nil
        end,
      })
      vim.list_extend(opts.sections.lualine_x, {
        -- {
        --   "diagnostics",
        --   symbols = {
        --     error = icons.diagnostics.Error,
        --     warn = icons.diagnostics.Warn,
        --     info = icons.diagnostics.Info,
        --     hint = icons.diagnostics.Hint,
        --   },
        -- },
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
            local shiftwidth = vim.fn.shiftwidth()
            return "󰌒" .. " " .. shiftwidth
          end,
          padding = 1,
        },
        -- { "filetype", icon_only = false, separator = "", padding = { left = 1, right = 2 } },
      })
      opts.sections.lualine_y = {
        { "location" },
      }
      opts.sections.lualine_z = {
        {
          "progress",
          fmt = function()
            return "%P/%L"
          end,
          color = {},
        },
      }
    end,
  },
}
