vim.pack.add { { src = 'https://github.com/epwalsh/pomo.nvim' } }

require("pomo").setup({
  sessions = {
    pomodoro = {
      { name = "Work",        duration = "55m" },
      { name = "Short Break", duration = "5m" },
      { name = "Work",        duration = "55m" },
      { name = "Short Break", duration = "5m" },
      { name = "Work",        duration = "55m" },
      { name = "Short Break", duration = "5m" },
      { name = "Work",        duration = "55m" },
      { name = "Short Break", duration = "5m" },
      { name = "Work",        duration = "55m" },
      { name = "Short Break", duration = "5m" },
      { name = "Work",        duration = "55m" },
      { name = "Short Break", duration = "5m" },
      { name = "Work",        duration = "55m" },
      { name = "Short Break", duration = "5m" },
      { name = "Work",        duration = "55m" },
      { name = "Finish work", duration = "5m" },
    },
  },
})
