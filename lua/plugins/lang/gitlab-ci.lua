-- https://github.com/alesbrelih/gitlab-ci-ls

-- TODO: figure this out, not working as expected

if true then
  return {}
end

return {
  -- Setup gitlab_ci_ls.
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      vim.filetype.add {
        pattern = {
          ["%.gitlab%-ci%.ya?ml"] = "yaml.gitlab",
        },
      }
      vim.list_extend(opts.servers, {
        gitlab_ci_ls = {},
      })
    end,
  },
}
