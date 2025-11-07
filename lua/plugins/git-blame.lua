vim.pack.add{{
	src = 'https://github.com/f-person/git-blame.nvim'}
}
require('gitblame').setup {
  display_virtual_text = false,
  enabled = true, -- if you want to enable the plugin
  message_template = '<<sha>> <date> • <author>', -- template for the blame message, check the Message template section for more options
  date_format = '%m-%d-%Y %H:%M', -- template for the date, check Date format section for more options
  virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
}
