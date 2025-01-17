-- https://github.com/supermaven-inc/supermaven-nvim

-- LazyVim issue to add supermaven as an Extra: https://github.com/LazyVim/LazyVim/pull/3491

if true then
  return {}
end

return {
  -- Configuring supermaven as a cmp source the LazyVim way. This means
  -- disabling inline completion and keymaps because we will see double ghost
  -- text.
  {
    "nvim-cmp",
    dependencies = {
      {
        "supermaven-inc/supermaven-nvim",
        event = "LspAttach",
        build = ":SupermavenUseFree", -- this line is optional, remove if you are using pro
        opts = {
          keymaps = {
            accept_suggestion = "<Tab>",
            clear_suggestion = "<C-]>",
            accept_word = "<C-j>",
          },
          disable_inline_completion = true, -- disables inline completion for use with cmp
          disable_keymaps = true, -- disables built in keymaps for more manual control
          condition = function()
            return false
          end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
        },
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      -- TODO: this doesn't work
      -- insert supermaven icon into this table
      table.insert(LazyVim.config.icons.kinds, {
        Supermaven = " ",
      })

      table.insert(opts.sources, 1, {
        name = "supermaven",
        group_index = 1,
        priority = 100,
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 2, LazyVim.lualine.cmp_source "supermaven")
    end,
  },
}
