-- https://github.com/milanglacier/minuet-ai.nvim

if true then
  return {}
end

local kind_icons = {
  -- LLM Provider icons
  claude = "󰋦",
  openai = "󱢆",
  openai_compatible = "󱢆",
  codestral = "󱎥",
  gemini = "",
  Groq = "",
  Openrouter = "󱂇",
  Ollama = "󰳆",
  ["Llama.cpp"] = "󰳆",
  Deepseek = "",
}

local source_icons = {
  minuet = "󱗻",
  orgmode = "",
  otter = "󰼁",
  nvim_lsp = "",
  lsp = "",
  buffer = "",
  luasnip = "",
  snippets = "",
  path = "",
  git = "",
  tags = "",
  cmdline = "󰘳",
  latex_symbols = "",
  cmp_nvim_r = "󰟔",
  codeium = "󰩂",
  -- FALLBACK
  fallback = "󰜚",
}

return {
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = {
      {
        "milanglacier/minuet-ai.nvim",
        opts = {
          provider = "openai_compatible",
          provider_options = {
            openai_compatible = {
              -- model = "gpt-4o",
              model = "gpt-4.1-mini",
              json = {
                -- model = "gpt-4o",
                model = "gpt-4.1-mini",
                -- max_tokens = 1024,
              },
              -- system = "see [Prompt] section for the default value",
              -- few_shots = "see [Prompt] section for the default value",
              -- chat_input = "See [Prompt Section for default value]",
              stream = true,
              end_point = "https://f5ai.pd.f5net.com/api/chat/completions",
              api_key = "OPENAI_API_KEY",
              name = "f5gpt",
              optional = {
                --   stop = nil,
                -- max_tokens = 256, -- default is nil
                -- temperature = 0.3,
                -- top_p = 0.9,
                -- presence_penalty = 0,
                -- frequency_penalty = 0.2,
              },
            },
          },
          -- The request timeout, measured in seconds. When streaming is enabled
          -- (stream = true), setting a shorter request_timeout allows for faster
          -- retrieval of completion items, albeit potentially incomplete.
          -- Conversely, with streaming disabled (stream = false), a timeout
          -- occurring before the LLM returns results will yield no completion items.
          -- Default: 3
          request_timeout = 1.5,
          -- If completion item has multiple lines, create another completion item
          -- only containing its first line. This option only has impact for cmp and
          -- blink. For virtualtext, no single line entry will be added.
          -- Default: true
          add_single_line_entry = false,
          -- The number of completion items encoded as part of the prompt for the
          -- chat LLM. For FIM model, this is the number of requests to send. It's
          -- important to note that when 'add_single_line_entry' is set to true, the
          -- actual number of returned items may exceed this value. Additionally, the
          -- LLM cannot guarantee the exact number of completion items specified, as
          -- this parameter serves only as a prompt guideline.
          -- Default: 3
          n_completions = 3,
        },
      },
    },
    opts = {
      keymap = {
        ["<C-y>"] = {
          function(cmp)
            cmp.show { providers = { "minuet" } }
          end,
        },
      },
      sources = {
        -- if you want to use auto-complete
        default = { "minuet" },
        providers = {
          minuet = {
            name = "minuet",
            module = "minuet.blink",
            score_offset = 100,
          },
        },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
        kind_icons = kind_icons,
      },
      -- ISSUE: Custom blink.cmp menu columns don't render source_icon
      -- The completion.menu.draw.columns config below attempts to add a source_icon
      -- column to show which completion source provided each item.
      -- However, blink.cmp's draw.components API doesn't support custom components
      -- the way this config expects. The source_icon component is not built-in.
      --
      -- To fix this, would need to:
      --   1. Check if blink.cmp supports custom draw components (may need PR)
      --   2. Or use a different approach like highlight groups per source
      --
      -- Note: This config uses work-specific f5ai.pd.f5net.com endpoint.
      -- Disabled until blink.cmp custom draw components are supported.
      -- completion = {
      --   menu = {
      --     draw = {
      --       columns = {
      --         { "label", "label_description", gap = 1 },
      --         { "kind_icon", "kind" },
      --         -- { "source_icon", "kind", gap = 1 },
      --         { "source_icon" },
      --       },
      --       components = {
      --         source_icon = {
      --           -- don't truncate source_icon
      --           ellipsis = false,
      --           text = function(ctx)
      --             return source_icons[ctx.source_name:lower()] or source_icons.fallback
      --           end,
      --           highlight = "BlinkCmpSource",
      --         },
      --       },
      --     },
      --   },
      -- },
    },
  },
}
