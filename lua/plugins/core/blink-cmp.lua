return {
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = {
      -- "saghen/blink.compat",
      -- {
      --   "Fildo7525/pretty_hover",
      --   event = "LspAttach",
      -- },
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
      sources = {
        default = { "omni" },
        -- providers = {
        --   omni = {
        --     module = "blink.cmp.sources.complete_func",
        --     enabled = function()
        --       return vim.bo.omnifunc ~= "v:lua.vim.lsp.omnifunc"
        --     end,
        --     ---@type blink.cmp.CompleteFuncOpts
        --     opts = {
        --       complete_func = function()
        --         return vim.bo.omnifunc
        --       end,
        --     },
        --     score_offset = 100,
        --   },
        -- },
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
        documentation = {
          window = { border = "single" },
          -- draw = function(opts)
          --   if opts.item and opts.item.documentation then
          --     local out = require("pretty_hover.parser").parse(opts.item.documentation.value)
          --     opts.item.documentation.value = out:string()
          --   end
          --
          --   opts.default_implementation(opts)
          -- end,
        },
      },
      signature = { window = { border = "single" } },
      -- 2025-09-17 LazyVim added cmdline completion to blink
      -- https://github.com/LazyVim/LazyVim/blob/bd1f523df58edd61eef10643ef9c42f9191ce617/lua/lazyvim/plugins/extras/coding/blink.lua?plain=1#L86-L98
      cmdline = {
        keymap = {
          -- preset = "cmdline",
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<TAB>"] = { "select_next", "fallback" },
          ["<S-TAB>"] = { "select_prev", "fallback" },
        },
        completion = {
          menu = {
            draw = {
              columns = { { "label", "label_description", gap = 1 } },
            },
          },
        },
      },
    },
  },
  -- {
  --   "saghen/blink.cmp",
  --   optional = true,
  --   dependencies = {
  --     {
  --       "milanglacier/minuet-ai.nvim",
  --       -- config = function()
  --       --   -- Your configuration options here
  --       --   require("minuet").setup {
  --       --     provider = "openai_fim_compatible",
  --       --     n_completions = 1, -- recommend for local model for resource saving
  --       --     -- I recommend beginning with a small context window size and incrementally
  --       --     -- expanding it, depending on your local computing power. A context window
  --       --     -- of 512, serves as an good starting point to estimate your computing
  --       --     -- power. Once you have a reliable estimate of your local computing power,
  --       --     -- you should adjust the context window to a larger value.
  --       --     context_window = 512,
  --       --     provider_options = {
  --       --       openai_fim_compatible = {
  --       --         api_key = "TERM",
  --       --         name = "Ollama",
  --       --         end_point = "http://localhost:11434/v1/completions",
  --       --         model = "qwen2.5-coder:7b",
  --       --         -- model = "deepseek-coder:6.7b",
  --       --         -- model = "starcoder2:7b",
  --       --         -- model = "deepseek-coder-v2",
  --       --         optional = {
  --       --           max_tokens = 56,
  --       --           top_p = 0.9,
  --       --         },
  --       --       },
  --       --     },
  --       --   }
  --       -- end,
  --       opts = {},
  --     },
  --   },
  --   opts = {
  --     -- blink.cmp configuration
  --     keymap = {
  --       -- Manually invoke minuet completion.
  --       -- ["<A-y>"] = require("minuet").make_blink_map(),
  --       ["<C-space>"] = require("minuet").make_blink_map(),
  --     },
  --     sources = {
  --       -- Enable minuet for autocomplete
  --       default = { "lsp", "path", "buffer", "snippets", "minuet" },
  --       -- For manual completion only, remove 'minuet' from default
  --       providers = {
  --         minuet = {
  --           name = "minuet",
  --           module = "minuet.blink",
  --           async = true,
  --           -- Should match minuet.config.request_timeout * 1000,
  --           -- since minuet.config.request_timeout is in seconds
  --           timeout_ms = 3000,
  --           score_offset = 50, -- Gives minuet higher priority among suggestions
  --         },
  --       },
  --     },
  --     -- Recommended to avoid unnecessary request
  --     completion = { trigger = { prefetch_on_insert = false } },
  --   },
  -- },
}
