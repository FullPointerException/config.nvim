local set = vim.opt_local

-- Set local terminal buffer settings
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", {}),
    callback = function ()
      set.number = false -- Disable line numbers
      set.relativenumber = false -- Disable relative numbers
      set.scrolloff = 0 -- Dont scroll to keep lines on screen
    end,
})

-- Make Escape accessible in terminal mode
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

-- Open terminal at the bottom of the screen with fixed wheight
vim.keymap.set("n", "<leader>t", function()
  vim.cmd.new()
  vim.cmd.wincmd "J"
  vim.api.nvim_win_set_height(0, 12)
  vim.wo.winfixheight = true
  vim.cmd.term()
  vim.cmd("startinsert")
end)
