vim.lsp.enable('ruff')
vim.lsp.config('ruff', {
  init_options = {
    settings = {
      configurationPreference = "filesystemFirst"
    }
  }
})
