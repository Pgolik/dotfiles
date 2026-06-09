require('plenary')
vim.pack.add { { src = 'https://github.com/epwalsh/obsidian.nvim' } }

require("obsidian").setup({
  workspaces = {
    {
      name = "GCPro",
      path = "/home/pagl/.project-docs/",
    },
  },
})

