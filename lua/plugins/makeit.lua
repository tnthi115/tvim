-- https://github.com/Zeioth/makeit.nvim

-- Define a function to check for the existence of a Makefile in the cwd
local function makefile_exists()
  return vim.fn.executable "make" == 1 and vim.fn.filereadable(vim.fn.getcwd() .. "/Makefile") == 1
end

return {
  {
    "Zeioth/makeit.nvim",
    -- May not be necessary.
    cond = makefile_exists,
    cmd = { "MakeitOpen", "MakeitToggleResults", "MakeitRedo" },
    keys = {
      { "<leader>cM", "<cmd>MakeitOpen<CR>", desc = "Run Makefile Target" },
    },
    dependencies = {
      { -- The task runner we use
        "stevearc/overseer.nvim",
        commit = "400e762648b70397d0d315e5acaf0ff3597f2d8b",
        cmd = { "MakeitOpen", "MakeitToggleResults", "MakeitRedo", "MakeitStop" },
        opts = {
          task_list = {
            direction = "bottom",
            min_height = 25,
            max_height = 25,
            default_detail = 1,
          },
        },
      },
    },
    opts = {},
  },
}
