-- https://github.com/LunarVim/breadcrumbs.nvim
-- https://github.com/SmiteshP/nvim-navic
-- No longer using: https://www.lazyvim.org/extras/editor/navic

return {
  {
    "LunarVim/breadcrumbs.nvim",
    enabled = false,
    dependencies = {
      "SmiteshP/nvim-navic",
      init = function()
        vim.g.navic_silence = true
        require("lazyvim.util").lsp.on_attach(function(client, buffer)
          if client.supports_method "textDocument/documentSymbol" then
            require("nvim-navic").attach(client, buffer)
          end
        end)
      end,
      opts = function()
        return {
          separator = " ",
          highlight = true,
          depth_limit = 5,
          icons = require("lazyvim.config").icons.kinds,
          lazy_update_context = true,
          lsp = {
            auto_attach = true,
          },
        }
      end,
    },
    event = "LazyFile",
    -- config = function()
    --   require("breadcrumbs").setup()
    -- end,
    config = true,
    -- opts = {},
  },
}
