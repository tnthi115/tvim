return {
  -- { import = "lazyvim.plugins.extras.editor.fzf" },
  {
    "ibhagwan/fzf-lua",
    optional = true,
    keys = {
      { "<leader>s/", "", desc = "Grep with glob" },
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
      { "<leader>gC", "<cmd>FzfLua git_branches<CR>", desc = "Branches" },
    },
    opts = {
      fzf_opts = {
        ["--layout"] = "default",
      },
    },
  },
}
