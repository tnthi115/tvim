-- https://github.com/utilyre/barbecue.nvim

return {
  "utilyre/barbecue.nvim",
  event = "LazyFile",
  name = "barbecue",
  version = "*",
  dependencies = {
    -- {
    --   "SmiteshP/nvim-navic",
    --   init = function()
    --     vim.g.navic_silence = true
    --     require("lazyvim.util").lsp.on_attach(function(client, buffer)
    --       if client.supports_method "textDocument/documentSymbol" then
    --         require("nvim-navic").attach(client, buffer)
    --       end
    --     end)
    --   end,
    --   opts = function()
    --     return {
    --       separator = " ",
    --       highlight = true,
    --       -- depth_limit = 5,
    --       icons = require("lazyvim.config").icons.kinds,
    --       -- lazy_update_context = true,
    --       lsp = {
    --         auto_attach = true,
    --       },
    --     }
    --   end,
    -- },
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    ---Whether to replace file icon with the modified symbol when buffer is
    ---modified.
    ---
    ---@type boolean
    show_modified = true,
    theme = {
      modified = { fg = require("tokyonight.colors").default.green },
    },
    -- kinds = {
    --   File = "",
    --   Module = "",
    --   Namespace = "",
    --   Package = "",
    --   Class = "",
    --   Method = "",
    --   Property = "",
    --   Field = "",
    --   Constructor = "",
    --   Enum = "",
    --   Interface = "",
    --   Function = "",
    --   Variable = "",
    --   Constant = "",
    --   String = "",
    --   Number = "",
    --   Boolean = "",
    --   Array = "",
    --   Object = "",
    --   Key = "",
    --   Null = "",
    --   EnumMember = "",
    --   Struct = "",
    --   Event = "",
    --   Operator = "",
    --   TypeParameter = "",
    -- },
    -- kinds = require("lazyvim.config").icons.kinds,
    kinds = {
      Array = "",
      Boolean = "󰨙",
      Class = "",
      Codeium = "󰘦",
      Color = "",
      Control = "",
      Collapsed = "",
      Constant = "󰏿",
      Constructor = "",
      Copilot = "",
      Enum = "",
      EnumMember = "",
      Event = "",
      Field = "",
      File = "",
      Folder = "",
      Function = "󰊕",
      Interface = "",
      Key = "",
      Keyword = "",
      Method = "󰊕",
      Module = "",
      Namespace = "󰦮",
      Null = "",
      Number = "󰎠",
      Object = "",
      Operator = "",
      Package = "",
      Property = "",
      Reference = "",
      Snippet = "",
      String = "",
      Struct = "󰆼",
      TabNine = "󰏚",
      Text = "",
      TypeParameter = "",
      Unit = "",
      Value = "",
      Variable = "󰀫",
    },
  },
}
