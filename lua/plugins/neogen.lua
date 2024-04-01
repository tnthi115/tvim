-- https://github.com/danymat/neogen
-- neogen - docstring/annotation toolkit for multiple languages using treesitter

return {
  {
    "danymat/neogen",
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
    event = "LspAttach",
    dependencies = "nvim-treesitter/nvim-treesitter",
    -- stylua: ignore
    keys = {
      { "<leader>nn", "<cmd>lua require('neogen').generate()<CR>", desc = "Generate Annotation" },
      { "<leader>nf", "<cmd>lua require('neogen').generate({ type = 'func' })<CR>", desc = "Generate Function Annotation" },
      { "<leader>nc", "<cmd>lua require('neogen').generate({ type = 'class' })<CR>", desc = "Generate Class Annotation" },
      { "<leader>nt", "<cmd>lua require('neogen').generate({ type = 'type' })<CR>", desc = "Generate Type Annotation" },
      { "<leader>nF", "<cmd>lua require('neogen').generate({ type = 'file' })<CR>", desc = "Generate File Annotation" },
    },
    opts = {
      enabled = true,
      input_after_comment = true,
      snippet_engine = "luasnip",
      languages = {
        lua = {
          template = {
            -- emmylua | ldoc
            annotation_convention = "emmylua",
            -- lunarvim I think uses ldoc, but this plugin doesn't seem to
            -- currently have as good support for it
            -- annotation_convention = "ldoc",
          },
        },
        python = {
          template = {
            -- google_docstrings | nympydoc | reST
            annotation_convention = "reST",
          },
        },
        go = {
          template = {
            annotation_convention = "godoc",
          },
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.defaults["<leader>n"] = { name = "+neogen" }
    end,
  },
}
