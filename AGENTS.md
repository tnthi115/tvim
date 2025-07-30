# AGENTS.md

## Build, Lint, and Test

- **Linting**:
  - Linting is handled via [nvim-lint](https://github.com/mfussenegger/nvim-lint) and configured in `lua/plugins/core/linting.lua`.
  - Linters are triggered on `BufWritePost`, `BufReadPost`, and `InsertLeave`.
  - Linters used: `codespell` (for markdown, html), `shellcheck` (for sh, bash).
  - To run a linter on the current buffer:
    `:lua require("lint").try_lint()`
- **Formatting**:
  - Lua code is formatted with [stylua](https://github.com/JohnnyMorganz/StyLua).
  - Format all Lua: `stylua .`
- **Testing**:
  - No explicit test runner is configured in this repo.
  - For plugin or Lua code, use `:luafile %` or write tests in `.test.lua` and run with `nvim -l .test.lua`.
  - **Always make sure there are no syntax errors. Test by running Neovim commands.**

## Code Style Guidelines

- **Indentation**: 2 spaces (see `stylua.toml` and options).
- **Line width**: 120 characters.
- **Line endings**: Unix (`\n`).
- **Quotes**: Prefer double quotes, but auto-detect.
- **Parentheses**: Omit call parentheses when possible in Lua.
- **Naming**:
  - Use `snake_case` for variables and functions.
  - Use `CamelCase` for plugin/class-like tables.
- **Imports/Requires**:
  - Use `require("module")` for Lua modules.
  - Group related requires at the top of files.
- **Error Handling**:
  - Use `pcall` for optional/unsafe requires.
  - Prefer explicit error messages for user-facing errors.
- **Keymaps/Autocmds**:
  - For plugin keymaps, prefer lazy.nvim's `keys` table in plugin specs.
  - Only use `vim.keymap.set()` for global keymaps in `lua/config/keymaps.lua`.
  - Place custom autocmds in `lua/config/autocmds.lua`.

## Development References

- **Config Search Order**:
  When searching for existing configuration, always check in this order:
  1. Your local config at `~/.config/nvim`
  2. Then `~/.local/share/nvim/lazy/LazyVim`
  3. Then the [LazyVim GitHub repo](https://github.com/LazyVim/LazyVim) or [LazyVim docs](https://www.lazyvim.org/)

- **Neovim Best Practices**:
  - Follow `:help lua-guide` for Lua in Neovim.
  - Use `:help api` for Neovim API documentation.
- **Plugin Development**:
  - Follow [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin specs.
  - Use lazy-loading with appropriate events or commands.
  - Structure new plugins in `lua/plugins/` directory.
  - Define keymaps using the `keys` table with proper descriptions for which-key integration.
- **LazyVim Standards**:
  - Reference [LazyVim docs](https://www.lazyvim.org/) for configuration patterns.
  - Check [LazyVim source](https://github.com/LazyVim/LazyVim) for implementation examples.
  - Extend LazyVim plugins in `lua/plugins/` following existing patterns.
- **FOSS Best Practices**:
  - Document all configuration options and functions.
  - Keep backward compatibility where possible.
  - Respect existing config patterns and structures.
  - Add TODO comments for future improvements.
