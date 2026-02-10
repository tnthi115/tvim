# tvim Development TODO

Personal development notes and planned improvements. Not user-facing.

## High Priority

- [ ] supermaven.lua - "doesn't work" (line 36)
- [ ] minuet-ai.lua - "doesn't work" (line 123)
- [ ] debugmaster.lua - Remap + FIXME (lines 31, 51)

## Medium Priority

- [ ] obsidian.lua - 3 incomplete features (lines 41, 60, 146)
- [ ] gitlab-ci.lua - Not working as expected (line 27)
- [ ] figure out how to show all messages in noice.nvim
- [ ] figure out how to ignore gitlab codesuggestions lsp messages
- [ ] figure out why hardtime.nvim doesn't work immediately when opening a file
  on the commandline (i.e `nvim <file>` or `vf`) and only works after opening
  another file
- [ ] figure out why obsidian.nvim syntax highlight doesn't work anymore
- [ ] figure out why image.nvim doesn't work anymore

## Low Priority / Ideas

- [ ] python.lua - Setup ruff with rules (line 20)
- [ ] markdown.lua - Open issue/PR in LazyVim (line 13)
- [ ] lualine.lua - Config duplication (lines 163, 200)
- [ ] use <https://stackoverflow.com/a/72021612> for work mode refactor
- [ ] tmux sessionX plugin <https://github.com/omerxx/tmux-sessionx>
- [ ] steal plugins from <https://github.com/jmbuhr/quarto-nvim-kickstarter>
- [ ] create custom snippets (lazy.nvim keys table, whichkey register mapping)
- [ ] look at <https://github.com/ibhagwan/fzf-lua>
- [ ] checkout [`markdown-oxide`](https://github.com/Feel-ix-343/markdown-oxide)
- [ ] change tokyonight highlights for git diffs in diffview
- [ ] replace nvim-colorizer with mini.hipatterns
- [ ] consider <https://github.com/rachartier/tiny-inline-diagnostic.nvim> or
  <https://github.com/sontungexpt/better-diagnostic-virtual-text>
  (using <https://git.sr.ht/~whynothugo/lsp_lines.nvim>)
- [ ] use <https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim> to auto
  update packages
- [ ] use quartz for publishing markdown notes
  (see <https://www.youtube.com/watch?v=DgKI4hZ4EEI>)

## Completed

- [x] add more treesitter textobjects
- [x] use conform.nvim and nvim-lint
- [x] refactor work mode if structure for `lang/go.lua`
- [x] add tmux navigator
- [x] update obsidian.nvim config after all the updates
- [x] configure image.nvim more
- [x] look at updates for [ogpt.nvim](https://github.com/huynle/ogpt.nvim)
- [x] look at <https://github.com/kawre/leetcode.nvim>
- [x] look at <https://github.com/soulis-1256/hoverhints.nvim> (doesn't work)
- [x] look at [nvim-navic](https://github.com/SmiteshP/nvim-navic) without
  breadcrumbs (using barbecue.nvim, switched to dropbar.lua)
- [x] configure cmp to give cmdline completion
- [x] add <https://github.com/LunarVim/bigfile.nvim>
- [x] update leetcode.nvim keybinds with new commands
- [x] figure out why breadcrumbs don't work for codesnap.nvim
- [x] figure out why the file icon in barbecue.nvim is no longer working
  (switched to dropbar.lua)
