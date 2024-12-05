local opt = vim.opt

-- Tabs are 2 spaces
opt.shiftwidth = 2
opt.expandtab = true

-- Don't add comments on "o" or newlines
opt.formatoptions:remove "o"
opt.formatoptions:remove "r"

-- Map to run Plenary test
vim.keymap.set("n", "<leader>t", "<Plug>PlenaryTestFile", { desc = "Run Plenary Tests for this plugin" })

-- Maps to run lua
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>", { desc = "Source current file" })
vim.keymap.set("n", "<space>x", ":.lua<CR>", { desc = "Execute current line" })
vim.keymap.set("v", "<space>x", ":lua<CR>", { desc = "Execute selected lines" })
