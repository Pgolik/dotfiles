vim.lsp.enable('ruff')
vim.lsp.config['ruff'] = {
    settings = {
      enabled = true,
      formatEnabled = true,
    }
}
