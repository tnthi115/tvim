-- https://github.com/milanglacier/minuet-ai.nvim

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
              model = "gpt-4o",
              -- system = "see [Prompt] section for the default value",
              -- few_shots = "see [Prompt] section for the default value",
              -- chat_input = "See [Prompt Section for default value]",
              stream = false,
              end_point = "https://f5ai.pd.f5net.com/api/chat/completions",
              api_key = "OPENAI_API_KEY",
              name = "f5gpt",
              optional = {
                stop = nil,
                max_tokens = nil,
              },
            },
          },
        },
      },
    },
    opts = {
      keymap = {
        ["<C-space>"] = {
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
      completion = {
        menu = {
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind" },
              { "source_icon" },
            },
            components = {
              source_icon = {
                -- don't truncate source_icon
                ellipsis = false,
                text = function(ctx)
                  return source_icons[ctx.source_name:lower()] or source_icons.fallback
                end,
                highlight = "BlinkCmpSource",
              },
            },
          },
        },
      },
    },
  },
}
