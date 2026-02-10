-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- macOS Sequoia (15.x+): Auto-sign .so/.dylib files to prevent SIGKILL crashes
-- See README.md "Known Issues / Workarounds" for removal conditions.
--
if vim.fn.has "mac" == 1 then
  local codesign_group = vim.api.nvim_create_augroup("CodesignPlugins", { clear = true })

  local function sign_all_nvim_libs()
    local data_dir = vim.fn.stdpath "data"
    local exclude_paths = {
      "*/codesnap.nvim/*", -- ships pre-signed binaries
    }
    local exclude_args = ""
    for _, path in ipairs(exclude_paths) do
      exclude_args = exclude_args .. string.format(' -not -path "%s"', path)
    end
    local cmd = string.format(
      'find "%s" \\( -name "*.so" -o -name "*.dylib" \\)%s -exec codesign -f -s - {} \\;',
      data_dir,
      exclude_args
    )
    vim.fn.jobstart(cmd, {
      detach = true,
      on_exit = function(_, code)
        if code == 0 then
          vim.notify("Signed nvim .so/.dylib files", vim.log.levels.INFO)
        end
      end,
    })
  end

  -- Sign after treesitter operations
  vim.api.nvim_create_autocmd("User", {
    group = codesign_group,
    pattern = { "TSUpdate", "TSInstallPost" },
    callback = sign_all_nvim_libs,
    desc = "Sign .so/.dylib files for macOS Sequoia",
  })

  -- Sign after mason operations
  vim.api.nvim_create_autocmd("User", {
    group = codesign_group,
    pattern = "MasonInstallAllComplete",
    callback = sign_all_nvim_libs,
    desc = "Sign .so/.dylib files for macOS Sequoia",
  })

  -- Sign after ANY lazy.nvim operation (catches rebuilds that don't fire TS events)
  vim.api.nvim_create_autocmd("User", {
    group = codesign_group,
    pattern = { "LazySync", "LazyUpdate", "LazyInstall" },
    callback = sign_all_nvim_libs,
    desc = "Sign .so/.dylib files for macOS Sequoia",
  })
end

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

-- Set indent size to 4 for fish files.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "fish",
  callback = function()
    local indent_size = 4
    vim.cmd(string.format("setlocal shiftwidth=%s softtabstop=%s expandtab", indent_size, indent_size))
  end,
})

-- Disable wrap for markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = false
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

-- Show staged diff in split when editing commit message (Fugitive, delta, or plain diff)
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "COMMIT_EDITMSG",
  callback = function()
    local commit_win = vim.api.nvim_get_current_win()

    -- Set up window/buffer first (sync part)
    local wins = vim.api.nvim_list_wins()
    local diff_win

    if #wins == 1 then
      -- Only one window, create a split
      vim.cmd "vsplit"
      wins = vim.api.nvim_list_wins()
    end

    -- Find the window that is not the commit message
    for _, win in ipairs(wins) do
      if win ~= commit_win then
        diff_win = win
        break
      end
    end

    if not diff_win then
      return -- No window to show diff
    end

    local diff_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(diff_win, diff_buf)
    vim.api.nvim_set_current_win(commit_win)

    -- Async git operations
    local function populate_diff(lines)
      if vim.api.nvim_buf_is_valid(diff_buf) and #lines > 0 then
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(diff_buf, 0, -1, false, lines)
          vim.bo[diff_buf].filetype = "diff"
        end)
      end
    end

    -- Try git diff --cached first
    local diff_lines = {}
    vim.fn.jobstart("git diff --cached", {
      stdout_buffered = true,
      on_stdout = function(_, data)
        if data then
          for _, line in ipairs(data) do
            if line ~= "" then
              table.insert(diff_lines, line)
            end
          end
        end
      end,
      on_exit = function(_, code)
        if code == 0 and #diff_lines > 0 then
          populate_diff(diff_lines)
        else
          -- Fallback: try git show HEAD (reword case)
          diff_lines = {}
          vim.fn.jobstart("git show HEAD --no-color --pretty=format:", {
            stdout_buffered = true,
            on_stdout = function(_, data)
              if data then
                for _, line in ipairs(data) do
                  if line ~= "" then
                    table.insert(diff_lines, line)
                  end
                end
              end
            end,
            on_exit = function(_, fallback_code)
              if fallback_code == 0 then
                populate_diff(diff_lines)
              end
            end,
          })
        end
      end,
    })
  end,
  desc = "Show staged diff in split when editing commit message",
})
