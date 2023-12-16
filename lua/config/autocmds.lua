-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Turn off auto comment after hitting 'o' or 'O' in Normal mode.
-- See :help fo-table
vim.api.nvim_create_autocmd("BufEnter", {
  command = "setlocal formatoptions-=o",
})

-- Keymap for xhtml files
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.html" },
  callback = function()
    vim.keymap.set("n", "<leader>M", "<cmd>!firefox %<CR>", { desc = "HTML Preview" })
  end,
})
