# PLUGINS KNOWLEDGE BASE

Plugin specifications for tvim. 51 files across 3 subdirectories.

## STRUCTURE

```text
plugins/
├── core/           # LazyVim overrides (20 files) - see core/AGENTS.md
├── lang/           # Language configs (12 files) - see lang/AGENTS.md
├── ai/             # Empty - AI configs live at root level
└── *.lua           # Custom plugins (51 files total)
```

## WHERE TO LOOK

| Task | Location | Notes |
|------|----------|-------|
| Override LazyVim core | `core/{plugin}.lua` | Use `opts` merge pattern |
| Language-specific | `lang/{lang}.lua` | LSP, formatters, linters |
| AI/Copilot | Root: `copilot.lua`, `avante.lua`, `codecompanion.lua` | Not in ai/ |
| Git tools | `neogit.lua`, `diffview.lua`, `gitlinker.lua`, `git-*.lua` | |
| Obsidian/Notes | `obsidian.lua` | Heavy customization |

## PLUGIN CATEGORIES

### AI/Completion (8)

`avante.lua`, `codecompanion.lua`, `copilot.lua`, `gen.lua`, `minuet-ai.lua`,
`ogpt.lua`, `sidekick.lua`, `supermaven.lua`

### Git Integration (9)

`diffview.lua`, `git-blame.lua`, `git-conflict.lua`, `git-worktree.lua`,
`gitlinker.lua`, `gitlab-duo-code-suggestions.lua`, `gitlab-mrs.lua`,
`neogit.lua`, `vim-fugative.lua`

### UI Enhancements (10)

`barbecue.lua`, `colorscheme.lua`, `dropbar.lua`, `fidget.lua`, `fzf.lua`,
`heirline.lua`, `image.lua`, `nvim-colorizer.lua`, `yazi.lua`, `zen-mode.lua`

### Coding Tools (9)

`codesnap.lua`, `debugmaster.lua`, `leetcode.lua`, `litee.lua`, `makeit.lua`,
`neogen.lua`, `nvim-bqf.lua`, `nvim-coverage.lua`, `refactoring.lua`

### Remote/Special (6)

`distant.lua`, `godot.lua`, `navigator.lua`, `obsidian.lua`, `opencode.lua`,
`remote-nvim.lua`

### Utility (5)

`bigfile.lua`, `example.lua`, `mini-splitjoin.lua`, `rabbit.lua`, `vscode.lua`

### Fun/Practice (4)

`cellular-automaton.lua`, `hardtime.lua`, `typr.lua`, `vim-be-good.lua`

## LAZY-LOADING PATTERNS

```lua
-- Event-based (most common)
event = "VeryLazy"           -- After UI loads
event = "BufReadPost"        -- When opening files

-- Filetype-based
ft = { "go", "gomod" }       -- Language-specific

-- Command-based
cmd = { "Neogit", "Git" }    -- On command invoke

-- Key-based
keys = { { "<leader>gg", ... } }  -- On keypress
```

## CONVENTIONS

- One plugin per file (named after main plugin)
- Return table with spec(s)
- Use `opts` for simple config, `config = function()` for complex
- Plugin keymaps go in `keys = {}`, not config/keymaps.lua

## ANTI-PATTERNS

- **DO NOT** create new files in `ai/` - AI plugins live at root
- **DO NOT** duplicate which-key registrations - use `keys` table descriptions
- **DO NOT** mix LSP server config here - use `core/lsp.lua` or `lang/*.lua`
