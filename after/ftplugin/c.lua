local opt = vim.opt

-- Tabs are 4 spaces
opt.shiftwidth = 4
opt.expandtab = true

-- Don't add comments on "o" or newlines
opt.formatoptions:remove "o"
opt.formatoptions:remove "r"

-- Add keymap to swap header / source
-- TODO: Use splitting etc for something better
vim.keymap.set("n", "<space>fo", function ()
  local fullname = vim.api.nvim_buf_get_name(0)
  -- If a .h file, swap to source
  if(fullname:sub(-2) == ".h") then
    local basename = fullname:sub(1, -2)

    local ccname = basename .. "cc"
    local cppname = basename .. "cpp"
    local cname = basename .. "c"
    local cxxname = basename .. "cxx"
    if (vim.fn.filereadable(ccname) == 1) then
      vim.cmd("e " .. ccname)
    elseif (vim.fn.filereadable(cppname) == 1) then
      vim.cmd("e " .. cppname)
    elseif (vim.fn.filereadable(cname) == 1) then
      vim.cmd("e " .. cname)
    elseif (vim.fn.filereadable(cxxname) == 1) then
      vim.cmd("e " .. cxxname)
    else
      print("Could not find source file for " .. fullname)
    end
  elseif(fullname:sub(-3) == ".cc") then
    local hname = fullname:sub(1, -3) .. "h"
    local hppname = fullname:sub(1, -3) .. "hpp"
    if (vim.fn.filereadable(hname) == 1) then
      vim.cmd("e " .. hname)
    elseif (vim.fn.filereadable(hppname) == 1) then
      vim.cmd("e " .. hppname)
    else
      print("Could not find header file for " .. fullname)
    end
  elseif(fullname:sub(-4) == ".cpp") then
    local hname = fullname:sub(1, -4) .. "h"
    local hppname = fullname:sub(1, -4) .. "hpp"
    if (vim.fn.filereadable(hname) == 1) then
      vim.cmd("e " .. hname)
    elseif (vim.fn.filereadable(hppname) == 1) then
      vim.cmd("e " .. hppname)
    else
      print("Could not find header file for " .. fullname)
    end
  end
end, { desc = "Swap header/source" })
