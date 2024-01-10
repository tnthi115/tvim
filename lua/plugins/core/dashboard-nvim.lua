-- Full spec: https://www.lazyvim.org/plugins/ui#dashboard-nvim

return {
  "nvimdev/dashboard-nvim",
  dependencies = {
    -- https://github.com/0x5a4/oogway.nvim
    "0x5a4/oogway.nvim",
    cmd = { "Oogway" },
  },
  opts = function(_, opts)
    vim.list_extend(
      opts.config.header,
      -- Image and quote.
      -- vim.split(require("oogway").inspire_me() .. "\n" .. require("oogway").what_is_your_wisdom() .. "\n", "\n")
      -- Quote only.
      vim.split(require("oogway").what_is_your_wisdom() .. "\n\n\n", "\n")
    )
  end,
}
