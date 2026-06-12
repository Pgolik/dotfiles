vim.api.nvim_create_user_command('FormatDisable', function()
  vim.g.disable_autoformat = true
end, {
  desc = 'Disable autoformat-on-save',
})
vim.api.nvim_create_user_command('FormatEnable', function()
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat-on-save',
})

vim.api.nvim_create_user_command('DiffviewToggle', function()
  if not vim.g.git_diffview_toggle then
    vim.cmd [[DiffviewOpen]]
  else
    vim.cmd [[DiffviewClose]]
  end
  vim.g.git_diffview_toggle = not vim.g.git_diffview_toggle
end, {
  desc = 'Toggle Diffview',
})

vim.api.nvim_create_user_command('TGrep', function(args)
  local live_grep = require('telescope.builtin').live_grep
  live_grep({ cwd = args.args })
end, {
  desc = 'Telescope Grep', nargs = "*", complete = "dir"
})
