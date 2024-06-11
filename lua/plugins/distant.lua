return {
  "chipsenkbeil/distant.nvim",
  branch = "v0.3",
  cmd = { "Distant", "DistantInstall", "DistantConnect" },
  config = function()
    require("distant"):setup {
      servers = {
        ["*"] = {
          connect = {
            default = {
              scheme = "ssh",
            },
          },
        },
        ["10.192.225.34"] = {
          -- cwd = "~/workspace/src/gitlab.com/volterra/ves.io/devtest",
          username = "xctest",
        },
      },
    }
  end,
}
