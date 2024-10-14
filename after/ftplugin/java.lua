local opt = vim.opt

-- Tabs are 4 spaces
opt.shiftwidth = 4
opt.expandtab = true

-- Don't add comments on "o" or newlines
opt.formatoptions:remove "o"
opt.formatoptions:remove "r"

