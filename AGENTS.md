# TVIM - NEOVIM CONFIG KNOWLEDGE BASE

**Generated:** 2026-02-09
**Commit:** fef3f2a
**Branch:** main

> **AGENT INSTRUCTION**: When modifying this config, check if this file or
> child AGENTS.md files (`lua/plugins/AGENTS.md`, `lua/plugins/core/AGENTS.md`,
> `lua/plugins/lang/AGENTS.md`) need updates. Update file counts, plugin lists,
> or TODOs if your changes affect them.

## OVERVIEW

LunarVim-inspired personal Neovim config built on LazyVim. 87 Lua files, ~7500
lines. 51 custom plugins + 30 LazyVim extras.

## STRUCTURE

```text
nvim/
├── init.lua              # Entry: requires config.lazy
├── lua/
│   ├── config/           # Core settings (4 files)
│   │   ├── lazy.lua      # Plugin bootstrap + imports
│   │   ├── options.lua   # Vim options (pre-lazy)
│   │   ├── keymaps.lua   # Global keymaps (VeryLazy)
│   │   └── autocmds.lua  # Custom autocmds (VeryLazy)
│   ├── plugins/          # Plugin specs (51 files) - see plugins/AGENTS.md
│   │   ├── core/         # LazyVim overrides (20 files)
│   │   └── lang/         # Language configs (12 files)
│   └── snippets/         # Custom snippets (empty)
├── stylua.toml           # Lua formatter config
├── lazyvim.json          # LazyVim extras manifest (30 enabled)
└── lazy-lock.json        # Plugin version lock
```

## WHERE TO LOOK

| Task | Location | Notes |
|------|----------|-------|
| Add new plugin | `lua/plugins/{name}.lua` | Return lazy.nvim spec table |
| Override LazyVim plugin | `lua/plugins/core/{name}.lua` | Merge via `opts` |
| Add language support | `lua/plugins/lang/{lang}.lua` | See existing patterns |
| Global keymaps | `lua/config/keymaps.lua` | Use `vim.keymap.set()` |
| Plugin keymaps | Plugin spec `keys = {}` table | Preferred for lazy-loading |
| Autocmds | `lua/config/autocmds.lua` | Use `vim.api.nvim_create_autocmd` |
| Vim options | `lua/config/options.lua` | Applied before lazy.nvim |
| Enable LazyVim extra | `lazyvim.json` | Preferred over import in lazy.lua |
| Disable plugin | `lua/plugins/core/disabled.lua` | `{ "plugin", enabled = false }` |

## CONVENTIONS

### Code Style (stylua.toml enforces)

- **Indent**: 2 spaces
- **Line width**: 120 chars
- **Quotes**: Double preferred
- **Call parens**: Omit when possible (`require "module"` not
  `require("module")`)

### Naming

- `snake_case` for variables/functions
- `CamelCase` for plugin/class tables
- Plugin files: `{plugin-name}.lua` (kebab-case)

### Plugin Spec Pattern

```lua
return {
  {
    "author/plugin-name",
    event = "VeryLazy",  -- or ft, cmd, keys for lazy-loading
    opts = { ... },      -- merged with upstream
    config = function(_, opts) ... end,  -- for complex setup
  },
}
```

### Override Pattern (LazyVim plugins)

```lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Modify opts table
      opts.servers.lua_ls = { ... }
    end,
  },
}
```

### Conditional Loading

```lua
if vim.g.vscode then return {} end  -- Guard non-VSCode features
```

## ANTI-PATTERNS (THIS PROJECT)

- **DO NOT** put keymaps in config/keymaps.lua if they're plugin-specific - use
  `keys` table
- **DO NOT** disable LazyVim extras by commenting imports - use `lazyvim.json`
  or `enabled = false`
- **DO NOT** add LSP servers outside lsp.lua or lang/*.lua files
- **NEVER** use `vim.cmd` for keymaps - use `vim.keymap.set()`
- **NEVER** modify lazy-lock.json manually

## COMMANDS

```bash
# Format Lua
stylua .

# Lint (in Neovim)
:lua require("lint").try_lint()

# Syntax check
nvim -l file.lua

# Check for errors
nvim --headless -c "qa"
```

## ACTIVE TODOs IN CODEBASE

| File | Issue | Priority |
|------|-------|----------|
| supermaven.lua:36 | "doesn't work" | High |
| minuet-ai.lua:123 | "doesn't work" | High |
| debugmaster.lua:31,51 | Remap + FIXME | Medium |
| obsidian.lua:41,60,146 | 3 incomplete features | Medium |
| lualine.lua:163,200 | Config duplication | Low |
| gitlab-ci.lua:27 | Not working as expected | Medium |
| python.lua:20 | Setup ruff with rules | Low |
| markdown.lua:13 | Open issue/PR in LazyVim | Low |

## NOTES

- **Config search order**: Local config → `~/.local/share/nvim/lazy/LazyVim` →
  LazyVim GitHub
- **Python LSP**: Uses `basedpyright` (set in options.lua)
- **Colorscheme**: Kanagawa primary (tokyonight, catppuccin fallbacks)
- **Transparent mode**: Enabled in tokyonight config
- **Neovim 0.11+**: Uses `vim.lsp.enable()` API for some LSPs (markdown.lua)
- LazyVim extras in `lazyvim.json` - 30 enabled including copilot, DAP, blink,
  and language packs
