vim.pack.add{
  { src = 'https://github.com/neovim/nvim-lspconfig' },
}
require('lsp/clangd')
require('lsp/cookbook')
require('lsp/hover')
