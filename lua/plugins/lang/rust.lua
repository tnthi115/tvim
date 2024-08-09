-- https://www.lazyvim.org/extras/lang/rust

-- Installation:

-- $ brew install rustup-init
-- $ rustup-init
-- $ rustup component add rust-analyzer

return {
  {
    "stevearc/conform.nvim",
    ft = "rust",
    opts = {
      formatters_by_ft = {
        rust = { "rustfmt" },
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      local wk = require "which-key"
      vim.api.nvim_create_autocmd("BufRead", {
        pattern = { "Cargo.toml" },
        callback = function()
          wk.add {
            "<leader>j",
            mode = { "n", "v" },
            group = "crates",
            icon = { icon = require("mini.icons").get("filetype", "toml"), color = "orange" },
          }
        end,
      })
      -- vim.api.nvim_create_autocmd("FileType", {
      --   pattern = { "rust" },
      --   callback = function()
      --     wk.add {
      --       "<leader>j",
      --       ft = { "rust" },
      --       group = "rust",
      --       icon = { icon = require("mini.icons").get("filetype", "rust"), color = "orange" },
      --     }
      --   end,
      -- })
    end,
  },
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    cmd = { "Crates" },
    keys = {
      {
        "<leader>j",
        mode = { "n", "v" },
        -- ft = { "toml" },
        group = "crates",
        icon = { icon = require("mini.icons").get("filetype", "toml"), color = "orange" },
      },
      { "<leader>jt", mode = "n", ft = { "toml" }, "<cmd>Crates toggle<CR>", desc = "Toggle" },
      { "<leader>jr", mode = "n", ft = { "toml" }, "<cmd>Crates reload<CR>", desc = "Reload" },
      { "<leader>js", mode = "n", ft = { "toml" }, "<cmd>Crates show_popup<CR>", desc = "Show Popup" },
      { "<leader>jc", mode = "n", ft = { "toml" }, "<cmd>Crates show_crate_popup<CR>", desc = "Show Popup" },
      { "<leader>jv", mode = "n", ft = { "toml" }, "<cmd>Crates show_versions_popup<CR>", desc = "Show Versions" },
      { "<leader>jf", mode = "n", ft = { "toml" }, "<cmd>Crates show_features_popup<CR>", desc = "Show Features" },
      {
        "<leader>jd",
        mode = "n",
        ft = { "toml" },
        "<cmd>Crates show_dependencies_popup<CR>",
        desc = "Show Dependencies",
      },
      { "<leader>ju", mode = { "n", "v" }, ft = { "toml" }, "<cmd>Crates update_crate<CR>", desc = "Update Crate" },
      { "<leader>jU", mode = { "n", "v" }, ft = { "toml" }, "<cmd>Crates update_crates<CR>", desc = "Update Crates" },
      {
        "<leader>ja",
        mode = { "n", "v" },
        ft = { "toml" },
        "<cmd>Crates update_all_crates<CR>",
        desc = "Update All Crates",
      },
      {
        "<leader>jx",
        mode = "n",
        ft = { "toml" },
        "<cmd>Crates expand_plain_crate_to_inline_table<CR>",
        desc = "Expand Plain Crate to Inline Table",
      },
      {
        "<leader>jX",
        mode = "n",
        ft = { "toml" },
        "<cmd>Crates extract_crate_into_table<CR>",
        desc = "Extract Crate Into Table",
      },
      { "<leader>jH", mode = "n", ft = { "toml" }, "<cmd>Crates open_homepage<CR>", desc = "Open Homepage" },
      { "<leader>jR", mode = "n", ft = { "toml" }, "<cmd>Crates open_repository<CR>", desc = "Open Repository" },
      { "<leader>jD", mode = "n", ft = { "toml" }, "<cmd>Crates open_documentation<CR>", desc = "Open Documentation" },
      { "<leader>jC", mode = "n", ft = { "toml" }, "<cmd>Crates open_crates_io<CR>", desc = "Open crates.io" },
    },
    -- opts = function(_, opts)
    --   opts.popup = {
    --     border = "rounded",
    --   }
    -- end,
    opts = {
      popup = {
        border = "rounded",
      },
    },
  },
  -- {
  --   "mrcjkb/rustaceanvim",
  --   keys = {
  --     {
  --       "<leader>j",
  --       -- ft = { "rust" },
  --       group = "rust",
  --       icon = { icon = require("mini.icons").get("filetype", "rust"), color = "orange" },
  --     },
  --     {
  --       "<leader>ja",
  --       ft = { "rust" },
  --       function()
  --         vim.cmd.RustLsp "codeAction"
  --       end,
  --       desc = "Code Action",
  --     },
  --     {
  --       "<leader>jr",
  --       ft = { "rust" },
  --       function()
  --         vim.cmd.RustLsp "debuggables"
  --       end,
  --       desc = "Rust debuggables",
  --     },
  --   },
  -- },
}
