-- https://github.com/VoxelPrismatic/rabbit.nvim

if true then
  return {}
end

return {
  {
    "voxelprismatic/rabbit.nvim",
    -- Important! The master branch is the previous version
    branch = "rewrite",
    -- Important! Rabbit should launch on startup to track buffers properly
    -- lazy = false,
    event = "VeryLazy",
    cmd = "Rabbit",
    keys = {
      { "<leader>b.", "<cmd>Rabbit<CR>", desc = "Open Rabbit" },
    },
    ---@type Rabbit.Config
    opts = {},
  },
}
