-- opgt - fork of jackMort/ChatGPT.nvim that uses ollama

return {
  "huynle/ogpt.nvim",
  event = "LazyFile",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    -- "nvim-telescope/telescope.nvim",
  },
  config = function()
    local opts = {
      api_host_cmd = "echo http://localhost:11434",
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
      -- show_quickfixes_cmd = "copen",
      -- add custom actions.json
      actions_paths = {},
    }

    require("ogpt").setup(opts)

    local which_key_ok, which_key = pcall(require, "which-key")
    if not which_key_ok then
      return
    end

    opts = {
      mode = { "n", "v" }, -- NORMAL and VISUAL mode
      prefix = "<leader>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    }

    local mappings = {
      o = {
        name = "OGPT",
        c = { "<cmd>OGPT<CR>", "OGPT" },
        a = { "<cmd>OGPTActAs<CR>", "OGPTActAs" },
        e = { "<cmd>OGPTEditWithInstruction<CR>", "Edit with instruction" },
        C = { "<cmd>OGPTRun complete_code<CR>", "Complete Code" },
        G = { "<cmd>OGPTRun grammar_correction<CR>", "Grammar Correction" },
        t = { "<cmd>OGPTRun translate<CR>", "Translate" },
        k = { "<cmd>OGPTRun keywords<CR>", "Keywords" },
        d = { "<cmd>OGPTRun docstring<CR>", "Docstring" },
        A = { "<cmd>OGPTRun add_tests<CR>", "Add Tests" },
        o = { "<cmd>OGPTRun optimize_code<CR>", "Optimize Code" },
        s = { "<cmd>OGPTRun summarize<CR>", "Summarize" },
        f = { "<cmd>OGPTRun fix_bugs<CR>", "Fix Bugs" },
        x = { "<cmd>OGPTRun explain_code<CR>", "Explain Code" },
        r = { "<cmd>OGPTRun roxygen_edit<CR>", "Roxygen Edit" },
        l = { "<cmd>OGPTRun code_readability_analysis<CR>", "Code Readability Analysis" },
      },
    }

    which_key.register(mappings, opts)
  end,
}
