vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Stop searching' })
vim.keymap.set('n', '<leader>e', "<Cmd>Neotree toggle<CR>", { desc = 'Open Neotree' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = 'Telescope Find Files' })
vim.keymap.set('n', '<leader>sj', require('telescope.builtin').jumplist, { desc = 'Telescope Jump List' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = 'Telescope Files Grep' })
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, { desc = 'Telescope Buffers' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = 'Telescope Diagnostics' })

vim.keymap.set('n', '<leader>to', ':tabnew<CR>', { desc = '[T]ab [O]pen' })
vim.keymap.set('n', '<leader>tc', ':tabnew<CR>', { desc = '[T]ab [C]close' })
vim.keymap.set('n', '<leader>gd', ':DiffviewToggle<CR>', { desc = '[G]it [D]iff' })
vim.keymap.set('n', '<leader>gc', ':DiffviewClose<CR>', { desc = '[G]it [C]lose Diff' })
vim.keymap.set('n', '<leader>.f', ":let @+ =expand('%') . ':' . line('.')<CR>",
  { desc = 'Get current full path with line' })
vim.keymap.set('n', '<leader>.r', ":let @+ =expand('%.') . ':' . line('.')<CR>",
  { desc = 'Get current relative path with line' })

-- Tmux jump between tmux and nvim with nvim keybindings
vim.keymap.set('n', '<c-h>', '<cmd>TmuxNavigateLeft<cr>', { desc = 'Move to left pane in tumx' })
vim.keymap.set('n', '<c-j>', '<cmd>TmuxNavigateDown<cr>', { desc = 'Move to down pane in tumx' })
vim.keymap.set('n', '<c-k>', '<cmd>TmuxNavigateUp<cr>', { desc = 'Move to up pane in tumx' })
vim.keymap.set('n', '<c-l>', '<cmd>TmuxNavigateRight<cr>', { desc = 'Move to right pane in tumx' })
