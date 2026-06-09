vim.lsp.enable('clangd')
local existing_on_attach = vim.lsp.config['clangd'].on_attach
local function on_attach(client, bufnr)
  existing_on_attach(client, bufnr)
  vim.keymap.set({ 'n', 'x' }, '<leader>ch', ':LspClangdSwitchSourceHeader<CR>',
    { buffer = bufnr, desc = 'LSP: [C]ode [H]eader switch', remap = false })
end
vim.lsp.config['clangd'] = {
  on_attach = on_attach
}
