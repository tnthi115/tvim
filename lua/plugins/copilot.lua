return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    optional = true,
    keys = {
      { "<leader>a", mode = { "n", "v" }, false },
      { "<leader>aa", mode = { "n", "v" }, false },
      { "<leader>ax", mode = { "n", "v" }, false },
      { "<leader>aq", mode = { "n", "v" }, false },
      { "<leader>ap", mode = { "n", "v" }, false },
      { "<leader>O", "", desc = "+copilotchat ai", mode = { "n", "v" } },
      {
        "<leader>Oa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>Ox",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>Oq",
        function()
          vim.ui.input({
            prompt = "Quick Chat: ",
          }, function(input)
            if input ~= "" then
              require("CopilotChat").ask(input)
            end
          end)
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>Op",
        function()
          require("CopilotChat").select_prompt()
        end,
        desc = "Prompt Actions (CopilotChat)",
        mode = { "n", "v" },
      },
    },
    opts = {
      model = "claude-3.7-sonnet",
      context = { "#buffers" },
      mappings = {
        reset = {
          normal = "<A-l>",
          insert = "<A-l>",
        },
      },
    },
  },
}
