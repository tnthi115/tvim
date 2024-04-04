-- Full spec: https://www.lazyvim.org/extras/lang/yaml

if true then
  return {}
end

return {
  {
    "stevearc/conform.nvim",
    ft = "yaml",
    opts = {
      formatters_by_ft = {
        yaml = { "yamlfmt" },
      },
    },
  },
}
