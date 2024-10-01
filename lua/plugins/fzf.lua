return {
  -- { import = "lazyvim.plugins.extras.editor.fzf" },
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      {
        "folke/which-key.nvim",
        opts = function(_, opts)
          local wk = require "which-key"
          wk.add { "<leader>s/", group = "Grep with glob" }
        end,
      },
    },
    keys = {
      { "<leader>s//", "<cmd>FzfLua live_grep_glob<CR>", desc = "Grep with glob" },
      {
        "<leader>s/m",
        function()
          require("fzf-lua").live_grep_glob {
            cmd = "rg --column --line-number --no-heading --color=always --smart-case --max-columns=4096 --iglob '!*lts*' --iglob '!*render*' --iglob '!*template*' -e",
          }
        end,
        desc = "Grep in m",
      },
      {
        "<leader>s/o",
        function()
          require("fzf-lua").live_grep_glob {
            cmd = "rg --column --line-number --no-heading --color=always --smart-case --max-columns=4096 --iglob '!*pbgo*' --iglob '!*pbswagger*' -e",
          }
        end,
        desc = "Grep in o",
      },
    },
    opts = {
      fzf_opts = {
        ["--layout"] = "default",
      },
    },
  },
}
