-- https://github.com/ldelossa/litee-calltree.nvim

return {
  {
    "ldelossa/litee.nvim",
    event = "LazyFile",
    opts = {
      notify = { enabled = false },
      panel = {
        orientation = "bottom",
        panel_size = 10,
      },
    },
    config = function(_, opts)
      require("litee.lib").setup(opts)
    end,
  },
  {
    "ldelossa/litee-calltree.nvim",
    dependencies = "ldelossa/litee.nvim",
    event = "LazyFile",
    keys = {
      { "<leader>ci", vim.lsp.buf.incoming_calls, desc = "Symbol Incoming Calls" },
      { "<leader>co", vim.lsp.buf.outgoing_calls, desc = "Symbol Outgoing Calls" },
    },
    opts = {
      on_open = "panel",
      map_resize_keys = false,
    },
    config = function(_, opts)
      require("litee.calltree").setup(opts)
    end,
  },
}
