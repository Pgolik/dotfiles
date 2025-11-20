vim.pack.add({{src="https://codeberg.org/elfahor/telescope-just.nvim"}})
require 'telescope'.setup {
  extensions = {
    just = {
      -- I rather suggest dropdown!
      theme = 'dropdown',
      -- A good option is to show a popup window.
      -- You can do that with tmux or toggleterm.
      action = function(command)
        vim.fn.system(command)
        print("Executed", command)
      end
    }
  }
}
