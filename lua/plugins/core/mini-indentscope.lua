-- Full spec: https://www.lazyvim.org/plugins/ui#miniindentscope

return {
  "echasnovski/mini.indentscope",
  opts = function(_, opts)
    local fg = require("tokyonight.colors").setup().fg
    vim.cmd [[hi MiniIndentscopeSymbol guifg=fg]]

    opts.draw = {
      animation = require("mini.indentscope").gen_animation.none(),
    }
  end,
}
