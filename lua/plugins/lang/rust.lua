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
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = function(_, opts)
      local which_key_ok, which_key = pcall(require, "which-key")
      if which_key_ok then
        local which_key_opts = {
          mode = "n", -- NORMAL mode
          prefix = "<leader>",
          buffer = vim.api.nvim_get_current_buf(), -- Local mappings
          silent = true, -- use `silent` when creating keymaps
          noremap = true, -- use `noremap` when creating keymaps
          nowait = true, -- use `nowait` when creating keymaps
        }
        local mappings = {
          j = {
            name = "Crates",
            t = { mode = "n", "<cmd>Crates toggle<CR>", "Toggle" },
            r = { mode = "n", "<cmd>Crates reload<CR>", "Reload" },
            s = { mode = "n", "<cmd>Crates show_popup<CR>", "Show Popup" },
            c = { mode = "n", "<cmd>Crates show_crate_popup<CR>", "Show Popup" },
            v = { mode = "n", "<cmd>Crates show_versions_popup<CR>", "Show Versions" },
            f = { mode = "n", "<cmd>Crates show_features_popup<CR>", "Show Features" },
            d = { mode = "n", "<cmd>Crates show_dependencies_popup<CR>", "Show Dependencies" },
            u = { mode = { "n", "v" }, "<cmd>Crates update_crate<CR>", "Update Crate" },
            U = { mode = { "n", "v" }, "<cmd>Crates update_crates<CR>", "Update Crates" },
            a = { mode = { "n", "v" }, "<cmd>Crates update_all_crates<CR>", "Update All Crates" },
            x = {
              mode = "n",
              "<cmd>Crates expand_plain_crate_to_inline_table<CR>",
              "Expand Plain Crate to Inline Table",
            },
            X = { mode = "n", "<cmd>Crates extract_crate_into_table<CR>", "Extract Crate Into Table" },
            H = { mode = "n", "<cmd>Crates open_homepage<CR>", "Open Homepage" },
            R = { mode = "n", "<cmd>Crates open_repository<CR>", "Open Repository" },
            D = { mode = "n", "<cmd>Crates open_documentation<CR>", "Open Documentation" },
            C = { mode = "n", "<cmd>Crates open_crates_io<CR>", "Open crates.io" },
          },
        }

        which_key.register(mappings, which_key_opts)
      end

      opts.popup = {
        border = "rounded",
      }
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    opts = {
      server = {
        on_attach = function(_, bufnr)
          local which_key_ok, which_key = pcall(require, "which-key")
          if which_key_ok then
            local opts = {
              mode = "n", -- NORMAL mode
              prefix = "<leader>",
              buffer = bufnr, -- Local mappings
              silent = true, -- use `silent` when creating keymaps
              noremap = true, -- use `noremap` when creating keymaps
              nowait = true, -- use `nowait` when creating keymaps
            }
            local mappings = {
              j = {
                name = "Rust",
                a = {
                  mode = "n",
                  function()
                    vim.cmd.RustLsp "codeAction"
                  end,
                  "Code Action",
                },
                r = {
                  mode = "n",
                  function()
                    vim.cmd.RustLsp "debuggables"
                  end,
                  "Rust debuggables",
                },
              },
            }

            which_key.register(mappings, opts)
          end
        end,
      },
    },
  },
}
