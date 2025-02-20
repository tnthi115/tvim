return {
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = {
      -- "saghen/blink.compat",
    },
    opts = {
      keymap = {
        -- The C-k doesn't get overwritten, so I'm hardcoding it here for now
        -- preset = "enter",
        -- preset enter --
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "accept", "fallback" },

        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        -- preset enter --

        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        -- ["<CR>"] = { "accept", "fallback" },
        -- ["<Tab>"] = { "select_next", "fallback" },
        -- ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      },
      appearance = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = true,
        -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- adjusts spacing to ensure icons are aligned
        -- nerd_font_variant = "normal",
      },
      completion = {
        menu = {
          border = "single",
          draw = {
            -- columns = { { "kind_icon" }, { "source_name" }, { "label", "label_description", gap = 1 } },
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon" }, { "source_name" } },
          },
        },
        documentation = { window = { border = "single" } },
      },
      signature = { window = { border = "single" } },
      cmdline = {
        enabled = true,
        -- keymap = nil, -- Inherits from top level `keymap` config when not set
        keymap = {
          preset = "super-tab",
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },
        },
        sources = function()
          local type = vim.fn.getcmdtype()
          -- Search forward and backward
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          -- Commands
          if type == ":" or type == "@" then
            return { "cmdline" }
          end
          return {}
        end,
        completion = {
          trigger = {
            show_on_blocked_trigger_characters = {},
            show_on_x_blocked_trigger_characters = nil, -- Inherits from top level `completion.trigger.show_on_blocked_trigger_characters` config when not set
          },
          menu = {
            auto_show = nil, -- Inherits from top level `completion.menu.auto_show` config when not set
            draw = {
              columns = { { "label", "label_description", gap = 1 } },
            },
          },
        },
      },
    },
  },
}
