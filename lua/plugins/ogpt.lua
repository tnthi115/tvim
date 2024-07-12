-- https://github.com/huynle/ogpt.nvim
-- opgt - fork of jackMort/ChatGPT.nvim that uses ollama

return {
  "huynle/ogpt.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    -- "nvim-telescope/telescope.nvim",
    {
      "folke/which-key.nvim",
      opts = function(_, opts)
        local wk = require "which-key"
        wk.add { "<leader>o", group = "ogpt", mode = { "n", "v" } }
      end,
    },
  },
  cmd = { "OGPT", "OGPTActAs", "OGPTCompleteCode", "OGPTFocus", "OGPTRun" },
  -- stylua: ignore
  keys = {
    { mode = { "n", "v" }, "<leader>oo", "<cmd>OGPT<CR>", desc = "OGPT" },
    { mode = { "n", "v" }, "<leader>of", "<cmd>OGPTFocus<CR>", desc = "OGPTFocus" },
    { mode = { "n", "v" }, "<leader>oa", "<cmd>OGPTActAs<CR>", desc = "OGPTActAs" },
    { mode = { "n", "v" }, "<leader>oe", "<cmd>OGPTRun edit_with_instructions<CR>", desc = "Edit With Instruction" },
    { mode = { "n", "v" }, "<leader>oc", "<cmd>OGPTRun edit_code_with_instructions<CR>", desc = "Edit Code With Instruction" },
    { mode = { "n", "v" }, "<leader>oC", "<cmd>OGPTCompleteCode<CR>", desc = "Complete Code" },
    { mode = { "n", "v" }, "<leader>oE", "<cmd>OGPTRun evaluate<CR>", desc = "Evaluate" },
    { mode = { "n", "v" }, "<leader>oi", "<cmd>OGPTRun get_info<CR>", desc = "Info" },
    { mode = { "n", "v" }, "<leader>oG", "<cmd>OGPTRun grammar_correction<CR>", desc = "Grammar Correction" },
    { mode = { "n", "v" }, "<leader>ot", "<cmd>OGPTRun translate<CR>", desc = "Translate" },
    { mode = { "n", "v" }, "<leader>ok", "<cmd>OGPTRun keywords<CR>", desc = "Keywords" },
    { mode = { "n", "v" }, "<leader>od", "<cmd>OGPTRun docstring<CR>", desc = "Docstring" },
    { mode = { "n", "v" }, "<leader>oA", "<cmd>OGPTRun add_tests<CR>", desc = "Add Tests" },
    { mode = { "n", "v" }, "<leader>oO", "<cmd>OGPTRun optimize_code<CR>", desc = "Optimize Code" },
    { mode = { "n", "v" }, "<leader>os", "<cmd>OGPTRun summarize<CR>", desc = "Summarize" },
    { mode = { "n", "v" }, "<leader>oF", "<cmd>OGPTRun fix_bugs<CR>", desc = "Fix Bugs" },
    { mode = { "n", "v" }, "<leader>ox", "<cmd>OGPTRun explain_code<CR>", desc = "Explain Code" },
    { mode = { "n", "v" }, "<leader>or", "<cmd>OGPTRun roxygen_edit<CR>", desc = "Roxygen Edit" },
    { mode = { "n", "v" }, "<leader>ol", "<cmd>OGPTRun code_readability_analysis<CR>", desc = "Code Readability Analysis" },
    { mode = { "n" }, "<leader>oq", "<cmd>OGPTRun quick_question<CR>", desc = "Quick Question" },
    { mode = { "n", "v" }, "<leader>oI", "<cmd>OGPTRun custom_input<CR>", desc = "Custom Input" },
  },
  opts = {
    default_provider = {
      -- can also support `textgenui`
      name = "ollama",
      -- api_host = os.getenv "OLLAMA_API_HOST",
      api_host = "http://localhost:11434",
      api_key = os.getenv "OLLAMA_API_KEY",
    },
    edit_with_instructions = {
      keymaps = {
        use_output_as_input = "<C-a>",
      },
    },
    api_params = {
      model = "mistral:7b-instruct",
    },
    api_edit_params = {
      model = "mistral:7b-instruct",
    },
    actions = {
      code_completion = {
        opts = {
          params = {
            model = "mistral:7b-instruct",
          },
        },
      },
      edit_code_with_instructions = {
        opts = {
          params = {
            model = "mistral:7b-instruct",
          },
        },
      },
      quick_question = {
        type = "chat",
        args = {
          question = {
            type = "string",
            optional = "true",
            default = function()
              return vim.fn.input "question: "
            end,
          },
        },
        opts = {
          system = "You are a helpful assistant",
          template = "{{question}}",
          strategy = "display",
        },
      },
      custom_input = {
        type = "chat",
        args = {
          instruction = {
            type = "string",
            optional = "true",
            default = function()
              return vim.fn.input "instruction: "
            end,
          },
        },
        opts = {
          system = "You are a helpful assistant",
          template = "Given the following snippet, {{instruction}}.\n\nsnippet:\n```{{filetype}}\n{{input}}\n```",
          strategy = "display",
        },
      },
    },
    -- show_quickfixes_cmd = "copen",
    -- add custom actions.json
    actions_paths = {},
  },
}
