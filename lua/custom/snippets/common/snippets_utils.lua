M = {}

local io = require("io");
local ls = require("luasnip");
local t = ls.text_node

local filetype_includes = {}
local rundir = debug.getinfo(1).source:match("@?(.*/)")
local filetype_mapping_fp = io.open(rundir .. "../filetype_includes.txt")
if filetype_mapping_fp ~= nil then
  while true do
    local line = filetype_mapping_fp:read("*line")
    if line == nil then
      break
    end

    local filetype = nil
    local aliases = {}
    for word in line:gmatch("[^%s]+") do
      if filetype == nil then
        filetype = word
      else
        table.insert(aliases, word)
      end
    end

    if filetype ~= nil then
      filetype_includes[filetype] = aliases
    end
  end
  filetype_mapping_fp:close()
end

M.load_ft_func = function(bufnr)
  local base = require("luasnip.extras.filetype_functions").extend_load_ft(filetype_includes)
  local res = base(bufnr)
  vim.list_extend(res, filetype_includes['all'])
  return res
end

M.ft_func = function(_)
  return vim.split(vim.bo.filetype, ".", { plain = true, trimempty = true })
end

-- Get the default classname: the filename with no extension or path
M.classname = function()
  return vim.fn.expand('%:t:r')
end

-- Insert a newline
M.new_line = function()
  return t{"", ""}
end

M.setup = function()
  for filetype, extends in pairs(filetype_includes) do
    ls.filetype_extend(filetype, extends)
  end
end

return M
