-- Full spec: https://www.lazyvim.org/plugins/treesitter

-- if true then
--   return {}
-- end

return {
  -- Treesitter is a new parser generator tool that we can
  -- use in Neovim to power faster and more accurate
  -- syntax highlighting.
  {
    "nvim-treesitter/nvim-treesitter",
    -- dependencies = {
    --   {
    --     "nvim-treesitter/nvim-treesitter-textobjects",
    --     config = function()
    --       -- When in diff mode, we want to use the default
    --       -- vim text objects c & C instead of the treesitter ones.
    --       local move = require "nvim-treesitter.textobjects.move" ---@type table<string,fun(...)>
    --       local configs = require "nvim-treesitter.configs"
    --       for name, fn in pairs(move) do
    --         if name:find "goto" == 1 then
    --           move[name] = function(q, ...)
    --             if vim.wo.diff then
    --               local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
    --               for key, query in pairs(config or {}) do
    --                 if q == query and key:find "[%]%[][cC]" then
    --                   vim.cmd("normal! " .. key)
    --                   return
    --                 end
    --               end
    --             end
    --             return fn(q, ...)
    --           end
    --         end
    --       end
    --     end,
    --   },
    -- },
    opts = function(_, opts)
      opts.textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          -- keymaps = {
          --   -- You can use the capture groups defined in textobjects.scm
          --   ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
          --   ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
          --   ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
          --   ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },
          --
          --   -- works for javascript/typescript files (custom capture I created in after/queries/ecma/textobjects.scm)
          --   ["a:"] = { query = "@property.outer", desc = "Select outer part of an object property" },
          --   ["i:"] = { query = "@property.inner", desc = "Select inner part of an object property" },
          --   ["l:"] = { query = "@property.lhs", desc = "Select left part of an object property" },
          --   ["r:"] = { query = "@property.rhs", desc = "Select right part of an object property" },
          --
          --   ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
          --   ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },
          --
          --   ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
          --   ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },
          --
          --   ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
          --   ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },
          --
          --   ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
          --   ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },
          --
          --   ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
          --   ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },
          --
          --   ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
          --   ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
          -- },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>tna"] = "@parameter.inner", -- swap parameters/argument with next
            ["<leader>tnp"] = "@property.outer", -- swap object property with next
            ["<leader>tnf"] = "@function.outer", -- swap function with next
          },
          swap_previous = {
            ["<leader>tpa"] = "@parameter.inner", -- swap parameters/argument with prev
            ["<leader>tpp"] = "@property.outer", -- swap object property with prev
            ["<leader>tpf"] = "@function.outer", -- swap function with previous
          },
        },
        --   move = {
        --     enable = true,
        --     goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
        --     goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
        --     goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
        --     goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
        --   },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            -- ["]f"] = { query = "@call.outer", desc = "Next function call start" },
            -- ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
            ["]f"] = { query = "@function.outer", desc = "Next method/function def start" },
            ["]c"] = { query = "@class.outer", desc = "Next class start" },
            ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
            ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            -- ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            -- ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_next_end = {
            -- ["]F"] = { query = "@call.outer", desc = "Next function call end" },
            -- ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
            ["]F"] = { query = "@function.outer", desc = "Next method/function def end" },
            ["]C"] = { query = "@class.outer", desc = "Next class end" },
            ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
            ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
          },
          goto_previous_start = {
            -- ["[f"] = { query = "@call.outer", desc = "Previous function call start" },
            -- ["[m"] = { query = "@function.outer", desc = "Previous method/function def start" },
            ["[f"] = { query = "@function.outer", desc = "Previous method/function def start" },
            ["[c"] = { query = "@class.outer", desc = "Previous class start" },
            ["[i"] = { query = "@conditional.outer", desc = "Previous conditional start" },
            ["[l"] = { query = "@loop.outer", desc = "Previous loop start" },
          },
          goto_previous_end = {
            -- ["[F"] = { query = "@call.outer", desc = "Previous function call end" },
            -- ["[M"] = { query = "@function.outer", desc = "Previous method/function def end" },
            ["[F"] = { query = "@function.outer", desc = "Previous method/function def end" },
            ["[C"] = { query = "@class.outer", desc = "Previous class end" },
            ["[I"] = { query = "@conditional.outer", desc = "Previous conditional end" },
            ["[L"] = { query = "@loop.outer", desc = "Previous loop end" },
          },
        },
      }

      local status_ok, which_key = pcall(require, "which-key")
      if not status_ok then
        return
      end

      local nopts = {
        mode = "n",
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
      }

      local mappings = {
        t = {
          name = "+treesitter",
          n = {
            name = "+next",
          },
          p = {
            name = "+previous",
          },
        },
      }

      which_key.register(mappings, nopts)
    end,
  },
}
