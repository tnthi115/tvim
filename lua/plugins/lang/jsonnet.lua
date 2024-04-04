return {
  -- Install treesitter parsers.
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "jsonnet" })
      end
    end,
  },
  -- Setup jsonnet_ls.
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        -- https://github.com/grafana/jsonnet-language-server/tree/main/editor/vim
        jsonnet_ls = {
          cmd = { "jsonnet-language-server", "-t" },
          settings = {
            ext_vars = {
              -- foo = "bar",
            },
            formatting = {
              -- default values
              Indent = 2,
              MaxBlankLines = 2,
              StringStyle = "single",
              CommentStyle = "slash",
              PrettyFieldNames = true,
              PadArrays = false,
              PadObjects = true,
              SortImports = true,
              UseImplicitPlus = true,
              StripEverything = false,
              StripComments = false,
              StripAllButComments = false,
            },
          },
        },
      },
    },
  },
}
