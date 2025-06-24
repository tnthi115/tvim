-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/vscode.lua

-- Steal keybinds from https://github.com/LazyVim/LazyVim/discussions/1443

if not vim.g.vscode then
  return {}
end

-- Add some vscode specific keymaps
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimKeymaps",
  callback = function()
    vim.keymap.set(
      "n",
      "<leader>e",
      [[<cmd>lua require('vscode').action('workbench.action.toggleSidebarVisibility', { args = { when = 'sideBarFocus' })<cr>]]
    )
    vim.keymap.set(
      "n",
      "<leader>e",
      [[<cmd>lua require('vscode').action('workbench.files.action.focusFilesExplorer', { args = { when = 'editorTextFocus'} })<cr>]]
    )
    vim.keymap.set("n", "gr", [[<cmd>lua require('vscode').action('editor.action.goToReferences')<cr>]])
    vim.keymap.set("n", "gy", [[<cmd>lua require('vscode').action('editor.action.goToTypeDefinition')<cr>]])
    vim.keymap.set("n", "<leader>gg", [[<cmd>lua require('vscode').action('lazygit-vscode.toggle')<cr>]])
    -- vim.keymap.set("n", "<c-/>", [[<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<cr>]])
  end,
})
