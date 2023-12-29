-- https://github.com/linrongbin16/gitlinker.nvim

return {
  "linrongbin16/gitlinker.nvim",
  config = function()
    require("gitlinker").setup()

    local which_key_ok, which_key = pcall(require, "which-key")
    if not which_key_ok then
      return
    end

    local opts = {
      mode = { "n", "v" }, -- NORMAL and VISUAL mode
      prefix = "<leader>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    }

    local mappings = {
      g = {
        L = {
          name = "+gitlinker",
          l = { "<cmd>GitLink<CR>", "Copy /blob URL to Clipboard" },
          L = { "<cmd>GitLink!<CR>", "Open /blob URL in Browser" },
          b = { "<cmd>GitLink blame<CR>", "Copy /blame URL to Clipboard" },
          B = { "<cmd>GitLink! blame<CR>", "Open /blame URL in Browser" },
        },
      },
    }

    which_key.register(mappings, opts)
  end,
}
