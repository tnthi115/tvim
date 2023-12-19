-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lu
-- Add any additional keymaps here

-- TODO: swap <leader>/ with comment
-- ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
-- vim.keymap.del("n", "<leader>/")
-- vim.keymap.set({ "n", "v" }, "<leader>/", "gcc", { desc = "Comment toggle current line" })

-- navigate commandline tab completion with <c-j> and <c-k>
-- runs conditionally
vim.keymap.set("c", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true })
vim.keymap.set("c", "<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true })

-- remove git status keybind
vim.keymap.del("n", "<leader>gs")

-- checkout branch
-- vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Checkout branch" })

-- noice.nvim use <c-d> and <c-u> for lsp hover doc scrolling
vim.keymap.set({ "n", "i", "s" }, "<c-d>", function()
  if not require("noice.lsp").scroll(4) then
    return "<c-d>"
  end
end, { silent = true, expr = true })

vim.keymap.set({ "n", "i", "s" }, "<c-u>", function()
  if not require("noice.lsp").scroll(-4) then
    return "<c-u>"
  end
end, { silent = true, expr = true })

-- TODO: add <leader>s/ as search current buffer

-- Utility function for setting local spacing.
-- function set_spaces()
--   vim.ui.input({ prompt = "Number of spaces: " }, function(input)
--     vim.cmd(string.format("setlocal shiftwidth=%s softtabstop=%s expandtab", input, input))
--   end)
--   -- vim.cmd [[redraw]]
-- end

vim.keymap.set("n", "<leader>uS", function()
  vim.ui.input({ prompt = "Number of spaces: " }, function(input)
    vim.cmd(string.format("setlocal shiftwidth=%s softtabstop=%s expandtab", input, input))
  end)
end, { desc = "Set spaces" })

-- Function for live grep with file mask
-- See :h Telescope.builtin.live_grep()
-- function telescope_live_grep_with_glob_pattern()
--   vim.ui.input({ prompt = "Glob pattern: " }, function(input)
--     vim.cmd(string.format("Telescope live_grep glob_pattern=%s", input))
--   end)
-- end

vim.keymap.set("n", "<leader>s.", function()
  vim.ui.input({ prompt = "Glob pattern: " }, function(input)
    vim.cmd(string.format("Telescope live_grep glob_pattern=%s", input))
  end)
end, { desc = "Live grep with glob pattern" })

-- Set keymaps for diagnostics like Lunarvim.
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "<leader>cj", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
vim.keymap.set("n", "<leader>ck", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })

-- Save without autoformatting.
vim.keymap.set("n", "<leader>bw", "<cmd>noautocmd w<cr>", { desc = "Save without formatting (noautocmd)" })
