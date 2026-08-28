-- Full spec: https://www.lazyvim.org/plugins/treesitter

-- 2025-09-17 Lazyvim update now uses the treesitter main branch, which requires the tree-sitter-cli
-- brew install tree-sitter-cli

-- if true then
--   return {}
-- end

local function move(key, method, query)
  return function()
    if vim.wo.diff and key:find "[cC]" then
      return vim.cmd("normal! " .. key)
    end
    require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
  end
end

local function swap(method, query)
  return function()
    require("nvim-treesitter-textobjects.swap")[method](query, "textobjects")
  end
end

return {
  -- Treesitter is a new parser generator tool that we can
  -- use in Neovim to power faster and more accurate
  -- syntax highlighting.
  {
    "nvim-treesitter/nvim-treesitter",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    opts = function()
      return {
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      }
    end,
    keys = {
      { "<leader>Tna", swap("swap_next", "@parameter.inner"), desc = "Swap parameter/argument with next" },
      { "<leader>Tnp", swap("swap_next", "@property.outer"), desc = "Swap object property with next" },
      { "<leader>Tnf", swap("swap_next", "@function.outer"), desc = "Swap function with next" },
      { "<leader>Tpa", swap("swap_previous", "@parameter.inner"), desc = "Swap parameter/argument with previous" },
      { "<leader>Tpp", swap("swap_previous", "@property.outer"), desc = "Swap object property with previous" },
      { "<leader>Tpf", swap("swap_previous", "@function.outer"), desc = "Swap function with previous" },
      {
        "]f",
        move("]f", "goto_next_start", "@function.outer"),
        mode = { "n", "x", "o" },
        desc = "Next method/function def start",
      },
      { "]c", move("]c", "goto_next_start", "@class.outer"), mode = { "n", "x", "o" }, desc = "Next class start" },
      {
        "]a",
        move("]a", "goto_next_start", "@parameter.inner"),
        mode = { "n", "x", "o" },
        desc = "Next parameter start",
      },
      {
        "]i",
        move("]i", "goto_next_start", "@conditional.outer"),
        mode = { "n", "x", "o" },
        desc = "Next conditional start",
      },
      { "]l", move("]l", "goto_next_start", "@loop.outer"), mode = { "n", "x", "o" }, desc = "Next loop start" },
      {
        "]F",
        move("]F", "goto_next_end", "@function.outer"),
        mode = { "n", "x", "o" },
        desc = "Next method/function def end",
      },
      { "]C", move("]C", "goto_next_end", "@class.outer"), mode = { "n", "x", "o" }, desc = "Next class end" },
      { "]A", move("]A", "goto_next_end", "@parameter.inner"), mode = { "n", "x", "o" }, desc = "Next parameter end" },
      {
        "]I",
        move("]I", "goto_next_end", "@conditional.outer"),
        mode = { "n", "x", "o" },
        desc = "Next conditional end",
      },
      { "]L", move("]L", "goto_next_end", "@loop.outer"), mode = { "n", "x", "o" }, desc = "Next loop end" },
      {
        "[f",
        move("[f", "goto_previous_start", "@function.outer"),
        mode = { "n", "x", "o" },
        desc = "Previous method/function def start",
      },
      {
        "[c",
        move("[c", "goto_previous_start", "@class.outer"),
        mode = { "n", "x", "o" },
        desc = "Previous class start",
      },
      {
        "[a",
        move("[a", "goto_previous_start", "@parameter.inner"),
        mode = { "n", "x", "o" },
        desc = "Previous parameter start",
      },
      {
        "[i",
        move("[i", "goto_previous_start", "@conditional.outer"),
        mode = { "n", "x", "o" },
        desc = "Previous conditional start",
      },
      {
        "[l",
        move("[l", "goto_previous_start", "@loop.outer"),
        mode = { "n", "x", "o" },
        desc = "Previous loop start",
      },
      {
        "[F",
        move("[F", "goto_previous_end", "@function.outer"),
        mode = { "n", "x", "o" },
        desc = "Previous method/function def end",
      },
      { "[C", move("[C", "goto_previous_end", "@class.outer"), mode = { "n", "x", "o" }, desc = "Previous class end" },
      {
        "[A",
        move("[A", "goto_previous_end", "@parameter.inner"),
        mode = { "n", "x", "o" },
        desc = "Previous parameter end",
      },
      {
        "[I",
        move("[I", "goto_previous_end", "@conditional.outer"),
        mode = { "n", "x", "o" },
        desc = "Previous conditional end",
      },
      { "[L", move("[L", "goto_previous_end", "@loop.outer"), mode = { "n", "x", "o" }, desc = "Previous loop end" },
    },
    config = function(_, opts)
      require("nvim-treesitter-textobjects").setup(opts)

      local status_ok, which_key = pcall(require, "which-key")
      if not status_ok then
        return
      end

      local mappings = {
        { "<leader>T", group = "treesitter", nowait = true, remap = false },
        { "<leader>Tn", group = "next", nowait = true, remap = false },
        { "<leader>Tp", group = "previous", nowait = true, remap = false },
      }

      which_key.add(mappings)
    end,
  },
}
