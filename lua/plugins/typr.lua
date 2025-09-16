-- https://github.com/nvzone/typr

vim.api.nvim_create_autocmd("FileType", {
  pattern = "typr",
  callback = function()
    vim.b.completion = false
  end,
})

return {
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    cmd = { "Typr", "TyprStats" },
    keys = {
      { "<leader>u.", "", desc = "games" },
      { "<leader>u.t", "<cmd>Typr<CR>", desc = "Typr" },
      { "<leader>u.T", "<cmd>TyprStats<CR>", desc = "TyprStats" },
    },
    opts = {},
  },
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      local keys = opts.dashboard.preset.keys
      if keys and #keys > 0 then
        -- Insert before the last element (which is "Quit")
        table.insert(keys, #keys, {
          icon = "󰗧 ",
          key = "t",
          desc = "Typr",
          action = ":Typr",
        })
      else
        -- Fallback if no keys exist
        opts.dashboard.preset.keys = {
          { icon = "󰗧 ", key = "t", desc = "Typr", action = ":Typr" },
        }
      end
    end,
  },
}
