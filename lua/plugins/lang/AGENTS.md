# LANGUAGE PLUGINS

12 files for language-specific configurations (LSP, formatters, linters,
treesitter).

## FILES

| File | Language | LSP | Formatter | Linter |
|------|----------|-----|-----------|--------|
| `dot.lua` | Graphviz | — | — | — |
| `fish.lua` | Fish shell | — | fish_indent | — |
| `git.lua` | Git files | — | — | gitlint |
| `gitlab-ci.lua` | GitLab CI | gitlab_ci_ls | — | — |
| `go.lua` | Go | gopls | gofumpt, goimports | golangci-lint |
| `help.lua` | Vim help | — | — | — |
| `jsonnet.lua` | Jsonnet | jsonnet_ls | jsonnetfmt | — |
| `lua.lua` | Lua | lua_ls | stylua | — |
| `markdown.lua` | Markdown | rumdl | — | — |
| `python.lua` | Python | basedpyright | black, isort | ruff |
| `rust.lua` | Rust | rust_analyzer | rustfmt | — |
| `yaml.lua` | YAML | yamlls | prettier | — |

## PATTERN

```lua
-- Standard language config structure
return {
  -- Treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "go", "gomod", "gowork" } },
  },

  -- LSP server config
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = { settings = { ... } },
      },
    },
  },

  -- Formatters
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = { go = { "gofumpt" } },
    },
  },

  -- Linters
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = { go = { "golangcilint" } },
    },
  },

  -- DAP (debugging)
  {
    "mfussenegger/nvim-dap",
    opts = { ... },
  },
}
```

## WHERE TO LOOK

| Task | Location |
|------|----------|
| Add new language | Create `lang/{lang}.lua` |
| Change Go settings | `go.lua` |
| Markdown rendering | `markdown.lua` (render-markdown.nvim) |
| Python LSP | `python.lua` (uses basedpyright) |

## CONVENTIONS

- One language per file
- File named after primary language/filetype
- Include ALL language tooling: LSP, formatter, linter, DAP, treesitter
- Use `ft = { ... }` or FileType autocmd for lazy loading

## NOTES

- **markdown.lua**: Uses rumdl LSP (new Neovim 0.11+ `vim.lsp.enable()` API),
  formatters disabled intentionally
- **python.lua**: basedpyright set globally in options.lua, ruff rules TODO

## ANTI-PATTERNS

- **DO NOT** configure language LSPs in `core/lsp.lua` - put them here
- **DO NOT** scatter formatters across files - consolidate per language
- **DO NOT** forget treesitter parsers when adding new languages
