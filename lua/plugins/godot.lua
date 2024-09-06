-- Setup gdscript and C# language support for godot.

-- Consider https://github.com/iabdelkareem/csharp.nvim, but it used omnisharp as the LSP.
-- https://youtu.be/cLWgjienc_s?si=GYdU9YV-dwhwoQIO

return {
  { import = "lazyvim.plugins.extras.lang.omnisharp" },
  -- Install treesitter parsers.
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "gdscript" })
    end,
  },
  -- Setup LSPs
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Set indent size to 4 for csharp files.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "cs",
        callback = function()
          local indent_size = 4
          vim.cmd(string.format("setlocal shiftwidth=%s softtabstop=%s expandtab", indent_size, indent_size))
        end,
      })

      vim.list_extend(opts.servers, {
        -- onmisharp added in lazyvim onmisharp extra
        -- gdscript lsp
        gdscript = {},
      })
    end,
  },
}
