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

-- Set indent size to 4 for csharp files.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "fish",
  callback = function()
    local indent_size = 4
    vim.cmd(string.format("setlocal shiftwidth=%s softtabstop=%s expandtab", indent_size, indent_size))
  end,
})

-- local lsp_cmds = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = lsp_cmds,
--   desc = "Code Lens Refresh",
--   callback = function(event)
--     local client = vim.lsp.get_client_by_id(event.data.client_id)
--     local bufnr = event.buf
--
--     local status_ok, codelens_supported = pcall(function()
--       return client.supports_method "textDocument/codeLens"
--     end)
--     if not status_ok or not codelens_supported then
--       return
--     end
--     local group = "lsp_code_lens_refresh"
--     local cl_events = { "BufEnter", "InsertLeave" }
--     local ok, cl_autocmds = pcall(vim.api.nvim_get_autocmds, {
--       group = group,
--       buffer = bufnr,
--       event = cl_events,
--     })
--
--     if ok and #cl_autocmds > 0 then
--       return
--     end
--     vim.api.nvim_create_augroup(group, { clear = false })
--     vim.api.nvim_create_autocmd(cl_events, {
--       group = group,
--       buffer = bufnr,
--       callback = vim.lsp.codelens.refresh,
--     })
--     vim.lsp.codelens.refresh()
--   end,
-- })
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = lsp_cmds,
--   desc = "Code Lens Action Keybind",
--   callback = function()
--     vim.keymap.set("n", "<leader>cL", "<cmd>lua vim.lsp.codelens.run()<cr>", { desc = "CodeLens Action" })
--   end,
-- })

-- vim.api.nvim_create_user_command("UpdateOperaImage", function()
--   require("telescope.builtin").grep_string { search = "opera_image", search_dirs = { "./params", "./versions" } }
--   require("telescope.actions").send_to_qflist(vim.api.nvim_get_current_buf())
-- end, { desc = "Update opera image digest" })

-- TODO: not working, but this is a temp solution before the image upgrade pipelines are made
-- vim.api.nvim_create_user_command("UpdateOperaImage", function()
--   -- Define the search pattern and directories
--   local search_pattern = "opera_image"
--   local search_dirs = { "./params", "./versions" }
--
--   -- Construct the grep command
--   local grep_cmd = "grep -rnwi '" .. search_pattern .. "' " .. table.concat(search_dirs, " ")
--
--   -- Execute the grep command and capture its output
--   local output = vim.fn.system(grep_cmd)
--
--   -- Split the output into lines and create a list of quickfix items
--   local qf_items = {}
--   for file, line_number, match in output:gmatch "([^%z]+):([^%z]+):([^%z]+)" do
--     -- Adjust the format to match the desired output
--     local formatted_entry = file .. "|" .. line_number .. " col 0| " .. match
--     table.insert(qf_items, { text = formatted_entry })
--   end
--
--   -- Populate the quickfix list with the search results
--   vim.fn.setqflist(qf_items)
--
--   -- Open the quickfix window
--   vim.cmd "copen"
-- end, { desc = "Update opera image digest" })
