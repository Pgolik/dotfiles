vim.lsp.enable('ts_ls')
vim.lsp.config['ts_ls'] = {
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'vue',
  },
}
