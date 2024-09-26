# 💤 tvim

This is my [Lunarvim](https://www.lunarvim.org/)-inspired config for [LazyVim](https://github.com/LazyVim/LazyVim).

## Installation

Follow the LazyVim Installation instructions, but clone this repo instead of
the LazyVim starter repo.

```sh
mv $HOME/.config/nvim/ $HOME/.config/nvim.bak
```

```sh
git clone git@github.com:tnthi115/lazyvim.git $HOME/.config/nvim
```

## TODO

- [ ] flesh out README
- [ ] screenshots
- [x] add more treesitter textobjects
- [x] use conform.nvim and nvim-lint
- [x] refactor work mode if structure for `lang/go.lua`
  - [ ] use https://stackoverflow.com/a/72021612
- [ ] figure out how to show all messages in noice.nvim
- [ ] figure out how to ignore gitlab codesuggestions lsp messages
- [x] add tmux navigator
- [ ] tmux sessionX plugin https://github.com/omerxx/tmux-sessionx
- [ ] steal plugins from quarto-nvim-kickstarter
  - [x] https://youtu.be/iNe88IZplYM?si=CENBMEgi64OdXrSQ
  - [ ] https://github.com/jmbuhr/quarto-nvim-kickstarter
  - [x] https://github.com/3rd/image.nvim/
- [x] update obsidian.nvim config after all the updates
- [x] configure image.nvim more
- [ ] figure out why hardtime.nvim doesn't work immediately when opening a file on the commandline (i.e `nvim <file>` or `vf`) and only works after opening another file
- [x] look at updates for [ogpt.nvim](https://github.com/huynle/ogpt.nvim)
- [ ] create custom snippets
  - [ ] lazy.nvim keys table
  - [ ] whichkey register mapping
- [ ] look at more plugins from https://github.com/rockerBOO/awesome-neovim
  - [x] https://github.com/kawre/leetcode.nvim
  - [x] look at https://github.com/soulis-1256/hoverhints.nvim
    - doesn't work
- [x] look at [nvim-navic](https://github.com/SmiteshP/nvim-navic) without breadcrumbs
  - [x] using https://github.com/utilyre/barbecue.nvim for now
- [ ] look at https://github.com/ibhagwan/fzf-lua
- [x] configure cmp to give cmdline completion
  - [x] done, but fix the selection confirmation
- [x] add https://github.com/LunarVim/bigfile.nvim or manual https://youtu.be/pf50INuhY-c?si=5deIZ9MMVE-8ycFI
- [x] update leetcode.nvim keybinds with new commands and update config if needed
- [ ] checkout [`markdown-oxide`](https://github.com/Feel-ix-343/markdown-oxide)
- [ ] change tokyonight highlights for git diffs in diffview
- [x] figure out why breadcrumbs don't work for [codesnap.nvim](https://github.com/mistricky/codesnap.nvim)
- [ ] figure out why obsidian.nvim syntax highlight doesn't work anymore
- [ ] figure out why image.nvim doesn't work anymore
- [ ] replace nvim-colorizer with mini.hipatterns
- [x] figure out why the file icon in barbecue.nvim is no longer working for some filetypes
  - switched to dropbar.lua
- [ ] consider https://github.com/rachartier/tiny-inline-diagnostic.nvim or https://github.com/sontungexpt/better-diagnostic-virtual-text
  - using https://git.sr.ht/~whynothugo/lsp_lines.nvim
- [x] use https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim to auto update packages
- [ ] use quartz for publishing markdown notes
  - see https://www.youtube.com/watch?v=DgKI4hZ4EEI
