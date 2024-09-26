-- Full spec: https://www.lazyvim.org/plugins/coding#nvim-cmp

local cmp = require "cmp"

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

return {
  {
    "hrsh7th/nvim-cmp",
    opts = {
      -- mapping = cmp.mapping.preset.insert {
      mapping = cmp.mapping.preset.insert {
        -- Add <C-j> and <C-K> keybinds for navigation.
        ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        -- Add <Tab> and <S-Tab> keybinds for navigation.
        -- https://github.com/hrsh7th/nvim-cmp/issues/286
        ["<Tab>"] = cmp.mapping(function(fallback)
          if vim.fn.pumvisible() == 1 then
            vim.fn.feedkey("<C-n>", "n")
          elseif cmp.visible() then
            cmp.select_next_item()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if vim.fn.pumvisible() == 1 then
            vim.fn.feedkey("<C-p>", "n")
          elseif cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        -- ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        -- ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        -- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        -- ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-a>"] = cmp.mapping.abort(),
        -- ["<CR>"] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        -- ["<S-CR>"] = cmp.mapping.confirm {
        --   behavior = cmp.ConfirmBehavior.Replace,
        --   select = true,
        -- }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        -- ["<C-CR>"] = function(fallback)
        --   cmp.abort()
        --   fallback()
        -- end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    },
  },
  -- better cmdline completion using cmp
  {
    "hrsh7th/cmp-cmdline",
    event = "CmdlineEnter",
    config = function()
      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        -- mapping = cmp.mapping.preset.cmdline(),
        mapping = {
          ["<Tab>"] = {
            c = function()
              if cmp.visible() then
                cmp.select_next_item()
              else
                cmp.complete()
              end
            end,
          },
          ["<S-Tab>"] = {
            c = function()
              if cmp.visible() then
                cmp.select_prev_item()
              else
                cmp.complete()
              end
            end,
          },
          ["<C-j>"] = {
            c = function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end,
          },
          ["<C-k>"] = {
            c = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end,
          },
          ["<C-n>"] = {
            c = function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end,
          },
          ["<C-p>"] = {
            c = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end,
          },
          ["<C-a>"] = {
            c = cmp.abort(),
          },
          ["<C-y>"] = {
            c = cmp.confirm { select = false },
          },
        },
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
          },
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        ---@diagnostic disable-next-line: missing-fields
        -- formatting = {
        --   format = function(_, item)
        --     local icons = require("lazyvim.config").icons.kinds
        --     if icons[item.kind] then
        --       item.kind = icons[item.kind] .. item.kind
        --     end
        --     return item
        --   end,
        -- },
        ---@diagnostic disable-next-line: missing-fields
        formatting = {
          format = function(_, item)
            -- Remove kind so only the word is displayed.
            item.kind = nil
            return item
          end,
        },
        completion = {
          completeopt = "menu,menuone,noinsert,noselect",
        },
      })

      -- `/` cmdline setup.
      cmp.setup.cmdline("/", {
        mapping = {
          ["<Tab>"] = {
            c = function()
              if cmp.visible() then
                cmp.select_next_item()
              else
                cmp.complete()
              end
            end,
          },
          ["<S-Tab>"] = {
            c = function()
              if cmp.visible() then
                cmp.select_prev_item()
              else
                cmp.complete()
              end
            end,
          },
          ["<C-j>"] = {
            c = function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end,
          },
          ["<C-k>"] = {
            c = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end,
          },
          ["<C-n>"] = {
            c = function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end,
          },
          ["<C-p>"] = {
            c = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end,
          },
          ["<C-a>"] = {
            c = cmp.abort(),
          },
          ["<C-y>"] = {
            c = cmp.confirm { select = false },
          },
        },
        sources = {
          { name = "buffer" },
        },
        completion = {
          completeopt = "menu,menuone,noinsert,noselect",
        },
      })
    end,
  },
  -- ai completion
  -- {
  --   "tzachar/cmp-ai",
  --   event = "LazyFile",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   config = function()
  --     -- cmp.setup {
  --     --   sources = {
  --     --     { name = "cmp_ai" },
  --     --   },
  --     -- }
  --
  --     cmp.setup {
  --       mapping = {
  --         ["<C-x>"] = cmp.mapping(
  --           cmp.mapping.complete {
  --             config = {
  --               sources = cmp.config.sources {
  --                 { name = "cmp_ai" },
  --               },
  --             },
  --           },
  --           { "i" }
  --         ),
  --       },
  --     }
  --
  --     local cmp_ai = require "cmp_ai.config"
  --
  --     cmp_ai:setup {
  --       max_lines = 100,
  --       provider = "Ollama",
  --       provider_options = {
  --         model = "deepseek-coder:6.7b",
  --       },
  --       notify = true,
  --       notify_callback = function(msg)
  --         vim.notify(msg)
  --       end,
  --       run_on_every_keystroke = true,
  --       ignored_file_types = {
  --         -- default is not to ignore
  --         -- uncomment to ignore in lua:
  --         -- lua = true
  --       },
  --     }
  --   end,
  -- },
}
