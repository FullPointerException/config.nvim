local opt = vim.opt

-- Show substitute results in a new split
opt.inccommand = "split"

-- Have search be case insensitive, unless I type uppercase letters
opt.ignorecase = true
opt.smartcase = true

-- Show relative line numbers, except for the current line
opt.relativenumber = true
opt.number = true

-- New buffers go down and right
opt.splitbelow = true
opt.splitright = true

-- Always reserve space for a sign collumn
opt.signcolumn = "yes"

-- Setup shared data file for history
opt.shada = { "'10", "<0", "s10", "h" }

-- Always use clipboard
opt.clipboard = "unnamedplus"

-- Don't have 'o' or new lines extend comments
opt.formatoptions:remove "o"
opt.formatoptions:remove "r"

-- Keep some lines on top / bottom of screen
opt.scrolloff = 8

-- Show Tabs, EOL whitespace, and newlines
vim.opt.list = true
vim.opt.listchars = {
  tab = '▸ ',
  trail = '·',
  eol = '↲',
}
