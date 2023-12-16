-- Full spec: https://www.lazyvim.org/plugins/ui#nvim-notify

if true then
  return {}
end

return {
  "rcarriga/nvim-notify",
  config = function()
    -- Ignore lsp error from gitlab.vim
    -- https://github.com/rcarriga/nvim-notify/issues/114
    local notify = vim.notify
    vim.notify = function(msg, ...)
      if msg:match "warning: multiple different client offset_encodings" then
        return
      end
      notify(msg, ...)
    end

    -- local banned_messages = {
    --   "warning: multiple different client offset_encodings detected for buffer, this is not supported yet",
    -- }
    --
    -- vim.notify = function(msg, ...)
    --   for _, banned in ipairs(banned_messages) do
    --     if msg == banned then
    --       return
    --     end
    --   end
    --   require "notify"(msg, ...)
    -- end
  end,
}
