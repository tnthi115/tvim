-- Full spec: https://www.lazyvim.org/extras/lang/typescript

if true then
  return {}
end

local ts_filetypes = { "typescript", "javascript" }

return {
  {
    "williamboman/mason.nvim",
    ft = ts_filetypes,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "prettierd" })
    end,
  },
  {
    "stevearc/conform.nvim",
    ft = ts_filetypes,
    opts = {
      formatters_by_ft = {
        typescript = { "prettierd" },
        javascript = { "prettierd" },
      },
    },
  },
}
