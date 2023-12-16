-- Full spec: https://www.lazyvim.org/plugins/lsp#nvim-lspconfig

return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    inlay_hints = {
      enabled = true,
    },
  },
  -- opts = function()
  --   -- local border = {
  --   --   { "🭽", "FloatBorder" },
  --   --   { "▔", "FloatBorder" },
  --   --   { "🭾", "FloatBorder" },
  --   --   { "▕", "FloatBorder" },
  --   --   { "🭿", "FloatBorder" },
  --   --   { "▁", "FloatBorder" },
  --   --   { "🭼", "FloatBorder" },
  --   --   { "▏", "FloatBorder" },
  --   -- }
  --   --
  --   -- -- LSP settings (for overriding per client)
  --   -- local handlers = {
  --   --   ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
  --   --   ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
  --   -- }
  --   --
  --   -- -- -- To instead override globally
  --   -- -- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  --   -- -- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  --   -- --   opts = opts or {}
  --   -- --   opts.border = opts.border or border
  --   -- --   return orig_util_open_floating_preview(contents, syntax, opts, ...)
  --   -- -- end
  --   -- local function set_handler_opts_if_not_set(name, handler, opts)
  --   --   if debug.getinfo(vim.lsp.handlers[name], "S").source:find(vim.env.VIMRUNTIME, 1, true) then
  --   --     vim.lsp.handlers[name] = vim.lsp.with(handler, opts)
  --   --   end
  --   -- end
  --   --
  --   -- set_handler_opts_if_not_set("textDocument/hover", vim.lsp.handlers.hover, { border = "rounded" })
  --   -- set_handler_opts_if_not_set("textDocument/signatureHelp", vim.lsp.handlers.signature_help, { border = "rounded" })
  --   --
  --   -- -- Enable rounded borders in :LspInfo window.
  --   -- require("lspconfig.ui.windows").default_options.border = "rounded"
  --
  --   return {
  --     inlay_hints = {
  --       enabled = true,
  --     },
  --   }
  -- end,
}
