-- https://github.com/David-Kunz/gen.nvim
-- ollama integration

return {
  "David-Kunz/gen.nvim",
  dependencies = {
    {
      "folke/which-key.nvim",
      opts = function(_, opts)
        local wk = require "which-key"
        wk.add { "<leader>G", group = "gen", mode = { "n", "v" } }
      end,
    },
  },
  cmd = "Gen",
  -- stylua: ignore
  keys = {
    { mode = { "n" }, "<leader>Gm", "<cmd>lua require('gen').select_model()<CR>", desc = "Select Model" },
    -- I'm not sure why yet, but using : instead of <cmd> allows for the visual selection to work.
    { mode = { "n", "v" }, "<leader>Gg", ":Gen<CR>", desc = "Gen" },
    { mode = { "n", "v" }, "<leader>Ga", ":Gen Ask<CR>", desc = "Gen Ask" },
    { mode = { "n", "v" }, "<leader>GC", ":Gen Change<CR>", desc = "Gen Change" },
    { mode = { "n", "v" }, "<leader>Gc", ":Gen Change_Code<CR>", desc = "Change Code" },
    { mode = { "n", "v" }, "<leader>Go", ":Gen Chat<CR>", desc = "Chat" },
    { mode = { "n", "v" }, "<leader>Ge", ":Gen Enhance_Code<CR>", desc = "Enhance Code" },
    { mode = { "n", "v" }, "<leader>GG", ":Gen Enhance_Grammar_Spelling<CR>", desc = "Enhance Grammar Spelling" },
    { mode = { "n", "v" }, "<leader>Gw", ":Gen Enhance_Wording<CR>", desc = "Enhance Wording" },
    { mode = { "n", "v" }, "<leader>GG", ":Gen Generate<CR>", desc = "Generate" },
    { mode = { "n", "v" }, "<leader>Gs", ":Gen Make_Consice<CR>", desc = "Make Consice" },
    { mode = { "n", "v" }, "<leader>Gl", ":Gen Make_List<CR>", desc = "Make List" },
    { mode = { "n", "v" }, "<leader>Gt", ":Gen Make_Table<CR>", desc = "Make Table" },
    { mode = { "n", "v" }, "<leader>Gr", ":Gen Review_Code<CR>", desc = "Review Code" },
    { mode = { "n", "v" }, "<leader>GS", ":Gen Summarize<CR>", desc = "Summarize" },
    -- Custom prompts
    { mode = { "n", "v" }, "<leader>GE", ":Gen Elaborate_Text<CR>", desc = "Elaborate Text" },
    { mode = { "n", "v" }, "<leader>Gf", ":Gen Fix_Code<CR>", desc = "Fix Code" },
  },
  config = function()
    local gen = require "gen"

    local opts = {
      model = "mistral:7b-instruct", -- The default model to use.
      display_mode = "float", -- The display mode. Can be "float" or "split".
      show_prompt = true, -- Shows the Prompt submitted to Ollama.
      show_model = true, -- Displays which model you are using at the beginning of your chat session.
      no_auto_close = false, -- Never closes the window automatically.
      init = function(options)
        pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
      end,
      -- Function to initialize Ollama
      command = "curl --silent --no-buffer -X POST http://localhost:11434/api/generate -d $body",
      -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
      -- This can also be a lua function returning a command string, with options as the input parameter.
      -- The executed command must return a JSON object with { response, context }
      -- (context property is optional).
      -- list_models = "<omitted lua function>", -- Retrieves a list of model names
      debug = false, -- Prints errors and the command which is run.
    }

    gen.setup(opts)

    -- Custom prompts: https://github.com/David-Kunz/gen.nvim#custom-prompts
    gen.prompts["Elaborate_Text"] = {
      prompt = "Elaborate the following text:\n$text",
      replace = true,
    }
    gen.prompts["Fix_Code"] = {
      prompt = "Fix the following code. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
      replace = true,
      extract = "```$filetype\n(.-)```",
    }
  end,
}
