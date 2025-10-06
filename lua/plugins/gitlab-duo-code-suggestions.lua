-- https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim
-- https://docs.gitlab.com/editor_extensions/neovim/setup/?tab=%60lazy.nvim%60

-- https://docs.gitlab.com/user/project/repository/code_suggestions/supported_extensions/#supported-languages-by-ide
local supported_languages = {
  "c", -- C
  "cpp", -- C++
  "csharp", -- C#
  "css", -- CSS (not supported in neovim)
  "go", -- Golang
  "haml",
  "html", -- HTML (not supported in neovim)
  "java", -- Java
  "javascript", -- JavaScript
  "javascriptreact", -- JavaScript React
  "kotlin", -- Kotlin
  "lua", -- Lua (not supported)
  "markdown", -- Markdown (not supported in neovim)
  "objective-c", -- Objective-C
  "objective-cpp", -- Objective-C++
  "php", -- PHP
  "python", -- Python
  "ruby", -- Ruby
  "rust", -- Rust
  "scala", -- Scala
  "sh", -- Shell scripts (bash only)
  "bash",
  "svelte", -- Svelte
  "sql", -- Google SQL
  "swift", -- Swift
  "terraform", -- Terraform
  "typescript", -- TypeScript
  "typescriptreact", -- TypeScript React
  "vue", -- Vue.js
}

return {
  {
    name = "gitlab-duo-code-suggestions",
    "https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git",
    -- "git@gitlab.com:gitlab-org/editor-extensions/gitlab.vim.git",
    enabled = true,
    -- event = { "BufReadPre", "BufNewFile" }, -- Activate when a file is created/opened
    -- event = { "LspAttach" },
    -- event = { "LazyFile" },
    ft = supported_languages, -- Activate when a supported filetype is open. For supported languages, see https://docs.gitlab.com/ee/user/project/repository/code_suggestions/index.html#supported-languages
    cond = function()
      -- Only activate is token is present in environment variable (remove to use interactive workflow)
      -- return vim.env.GITLAB_DUO_AI_TOKEN ~= nil and vim.env.GITLAB_DUO_AI_TOKEN ~= ""
      return vim.env.GITLAB_TOKEN ~= nil and vim.env.GITLAB_TOKEN ~= ""
    end,
    keys = {
      { "<leader>cu", "", desc = "ui/toggles" },
      { "<leader>cug", "<Plug>(GitLabToggleCodeSuggestions)", desc = "Toggle Gitlab Duo Code Suggestions" },
    },
    opts = {
      statusline = {
        enabled = false, -- Hook into the builtin statusline to indicate the status of the GitLab Duo Code Suggestions integration
      },
      code_suggestions = {
        -- For the full list of default languages, see the 'auto_filetypes' array in
        -- https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim/-/blob/main/lua/gitlab/config/defaults.lua
        auto_filetypes = supported_languages,
        ghost_text = {
          enabled = true,
          toggle_enabled = "<C-h>",
          -- accept_suggestion = "<C-l>",
          accept_suggestion = "<Tab>",
          clear_suggestions = "<C-k>",
          stream = true,
        },
      },
      language_server = {
        workspace_settings = {
          telemetry = {
            enabled = false,
          },
        },
      },
    },
  },
}
