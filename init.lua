-- bootstrap lazy.nvim, LazyVim and your plugins
require "config.lazy"
-- local bg_color = "#1a1b26"
-- vim.cmd [[hi NormalFloat ctermbg=none guibg=bg_color]]
-- vim.cmd [[hi CmpMenu ctermbg=none guibg=bg_color]]
-- vim.cmd [[hi CmpItemMenu ctermbg=none guibg=bg_color]]
-- vim.cmd [[hi CmpDocumentation ctermbg=none guibg=bg_color]]
-- vim.cmd [[hi link CmpMenu NormalFloat]]
-- vim.cmd [[hi link CmpItemMenu NormalFloat]]
-- vim.cmd [[hi link CmpDocumentation NormalFloat]]
-- vim.cmd [[hi FloatShadow ctermbg=none guibg=bg_color]]
-- vim.cmd [[hi FloatShadowThrough ctermbg=none guibg=bg_color]]
vim.cmd [[autocmd! ColorScheme * highlight NoiceLspProgressSpinner guibg=bg_color]]
vim.cmd [[autocmd! ColorScheme * highlight NoiceLspProgressTitle guibg=bg_color]]
vim.cmd [[autocmd! ColorScheme * highlight NoiceLspProgressClient guibg=bg_color]]
vim.cmd [[highlight NoiceLspProgressSpinner guibg=bg_color]]
vim.cmd [[highlight NoiceLspProgressTitle guibg=bg_color]]
vim.cmd [[highlight NoiceLspProgressClient guibg=bg_color]]
