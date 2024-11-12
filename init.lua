-- [[
-- Initialization
--
-- lazy.nvim initialization from: https://github.com/tjdevries/config.nvim/blob/master/init.lua
-- ]]

vim.env.PATH = "~/.nvm/versions/node/v22.11.0/bin" .. vim.env.PATH

vim.g.mapleader = ","

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end

-- Add lazy to the `runtimepath`, this allows us to `require` it.
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)


-- Set up lazy, and load my `lua/custom/plugins/` folder
require("lazy").setup({ import = "custom/plugins" }, {
  change_detection = {
    notify = false,
  },
})
