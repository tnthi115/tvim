-- Full spec: https://www.lazyvim.org/plugins/ui#miniindentscope

return {
  {
    "echasnovski/mini.indentscope",
    enabled = false,
    opts = {
      draw = {
        -- delay = 0,
        animation = require("mini.indentscope").gen_animation.none(),
      },
    },
  },
}
