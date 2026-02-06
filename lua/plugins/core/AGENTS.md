# CORE PLUGINS - LAZYVIM OVERRIDES

20 files overriding LazyVim default plugin configurations.

## PURPOSE

Override LazyVim's built-in plugins without forking. Uses lazy.nvim spec
merging.

## FILES

| File | Overrides | Key Customizations |
|------|-----------|-------------------|
| `blink-cmp.lua` | Completion | Custom sources, keymaps |
| `bufferline.lua` | Tab bar | Minimal changes |
| `cmp.lua` | nvim-cmp | Cmdline completion, sources |
| `dashboard-nvim.lua` | Dashboard | Custom ASCII art, shortcuts |
| `disabled.lua` | — | Plugin disabling (centralized) |
| `flash.lua` | Motion | Jump labels config |
| `gitsigns.lua` | Git signs | Blame, hunk actions |
| `indent-blankline.lua` | Indent guides | Scope highlighting |
| `linting.lua` | nvim-lint | codespell, shellcheck |
| `lsp.lua` | LSP core | Rounded borders, mason-tool-installer |
| `lualine.lua` | Statusline | Custom components, theme |
| `neo-tree.lua` | File tree | Keymaps, icons |
| `noice.lua` | Notifications | LSP progress, cmdline |
| `nvim-notify.lua` | Notify | Position, timeout |
| `nvim-spectre.lua` | Search/replace | Minimal |
| `snacks.lua` | Snacks.nvim | Bigfile, dashboard, picker |
| `telescope.lua` | Fuzzy finder | Extensions, mappings |
| `todo-comments.lua` | TODO highlights | Keywords |
| `treesitter.lua` | Syntax | Extra parsers, textobjects |
| `which-key.lua` | Key hints | Group labels |

## OVERRIDE PATTERN

```lua
return {
  {
    "plugin/name",
    opts = { ... },  -- Merged with LazyVim defaults
  },
}

-- For complex modifications:
return {
  {
    "plugin/name",
    opts = function(_, opts)
      opts.some_option = "value"
      table.insert(opts.list, item)
    end,
  },
}
```

## WHERE TO LOOK

| Task | File |
|------|------|
| Add LSP server | `lsp.lua` (mason-tool-installer list) |
| Change completion behavior | `blink-cmp.lua` or `cmp.lua` |
| Statusline changes | `lualine.lua` |
| File tree keymaps | `neo-tree.lua` |
| Add treesitter parser | `treesitter.lua` |
| Disable a plugin | `disabled.lua` |

## ANTI-PATTERNS

- **DO NOT** duplicate LazyVim's entire plugin spec - only override what differs
- **DO NOT** use `config = function()` if `opts` suffices
- **DO NOT** add language-specific LSP here - use `lang/*.lua`
