if true then
  return {}
end

return {
  -- https://github.com/sbulav/validate-gitlab-ci.nvim
  {
    "sbulav/validate-gitlab-ci.nvim",
    -- "tnthi115/validate-gitlab-ci.nvim", -- use my fork with the fix for now
    enabled = false,
    event = "BufEnter .gitlab-ci.yml",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.api.nvim_create_augroup("ValidateGitlabCIfiles", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          require("validate-gitlab-ci.validate-gitlab-ci").validate()
        end,
        group = "ValidateGitlabCIfiles",
        desc = "Validate Gitlab CI  files on save",
        pattern = ".gitlab-ci.yml",
      })
    end,
  },
  -- Setup gitlab_ci_ls.
  -- https://github.com/alesbrelih/gitlab-ci-ls
  -- TODO: figure this out, not working as expected
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      vim.filetype.add {
        pattern = {
          ["%.gitlab%-ci%.ya?ml"] = "yaml.gitlab",
        },
      }
      opts.servers.gitlab_ci_ls = {}
    end,
  },
}
