# Contributing to tvim

Thanks for your interest! This is a personal Neovim config, but contributions
are welcome.

## How to Contribute

- **Bug reports**: Open a GitHub Issue with reproduction steps
- **Feature suggestions**: Open an Issue to discuss before submitting a PR
- **Pull requests**: For bug fixes or improvements (please discuss first)

## Development Setup

1. Fork the repository
2. Clone to `~/.config/nvim` (backup existing config first)
3. Make your changes
4. Test with `nvim --headless -c "qa"` (should exit cleanly)
5. Format with `stylua .`
6. Submit a PR with a clear description

## Code Style

This project uses [stylua](https://github.com/JohnnyMorganz/StyLua) for
formatting. See `stylua.toml` for configuration:

- 2-space indentation
- 120 character line width
- Double quotes preferred
- Omit call parentheses when possible (e.g., `require "module"`)

Run `stylua .` before committing.

## Plugin Conventions

- **One plugin per file** in `lua/plugins/`
- **Use lazy.nvim spec format**:

  ```lua
  return {
    {
      "author/plugin-name",
      event = "VeryLazy",  -- or ft, cmd, keys for lazy-loading
      opts = { ... },
    },
  }
  ```

- **Prefer `opts` table** over `config` function when possible
- **Add keymaps in plugin spec** `keys` table (not in keymaps.lua)
- **LazyVim overrides** go in `lua/plugins/core/`
- **Language support** goes in `lua/plugins/lang/`

## Commit Messages

Use [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` new feature
- `fix:` bug fix
- `docs:` documentation only
- `refactor:` code change without feature/fix
- `chore:` maintenance tasks

## Questions?

Open an Issue if you have questions or need clarification.
