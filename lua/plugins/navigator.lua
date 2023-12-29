-- https://github.com/numToStr/Navigator.nvim

return {
  "numToStr/Navigator.nvim",
  keys = {
    { mode = { "n", "t" }, "<C-h>", "<cmd>NavigatorLeft<CR>" },
    { mode = { "n", "t" }, "<C-j>", "<cmd>NavigatorDown<CR>" },
    { mode = { "n", "t" }, "<C-k>", "<cmd>NavigatorUp<CR>" },
    { mode = { "n", "t" }, "<C-l>", "<cmd>NavigatorRight<CR>" },
  },
  opts = {
    -- Save modified buffer(s) when moving to mux
    -- nil - Don't save (default)
    -- 'current' - Only save the current modified buffer
    -- 'all' - Save all the buffers
    auto_save = nil,

    -- Disable navigation when the current mux pane is zoomed in
    disable_on_zoom = false,

    -- Multiplexer to use
    -- 'auto' - Chooses mux based on priority (default)
    -- table - Custom mux to use
    mux = "auto",
  },
}
