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
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Escape terminal mode" })

-- Open terminal at the bottom of the screen with fixed wheight
vim.keymap.set("n", "<space>st", function()
  vim.cmd.new()
  vim.cmd.wincmd "J"
  vim.api.nvim_win_set_height(0, 12)
  vim.wo.winfixheight = true
  vim.cmd.term()
  vim.cmd("startinsert")
end, { desc = "Split to terminal at bottom of screen" })

-- State to manage floating terminals
local floating_terminal_state = {
  term0 = {
    buf = -1,
    win = -1,
  }
}

-- Creates a single floating window
local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.9)
  local height = opts.height or math.floor(vim.o.lines * 0.9)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    local no_file = false
    local scratch_buffer = true
    buf = vim.api.nvim_create_buf(no_file, scratch_buffer)
  end

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

-- Toggles the floating terminal
local toggle_terminal = function()
  if vim.api.nvim_win_is_valid(floating_terminal_state.term0.win) then
    vim.api.nvim_win_hide(floating_terminal_state.term0.win)
  else
    floating_terminal_state.term0 = create_floating_window({ buf = floating_terminal_state.term0.buf })
    if vim.bo[floating_terminal_state.term0.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  end
  vim.cmd("normal i")
end

vim.api.nvim_create_user_command("FloatTerm", toggle_terminal, {})

vim.keymap.set( {"n", "t"}, "<space>tt", "<CMD>FloatTerm<CR>", { desc = "Toggle floating terminal" })
