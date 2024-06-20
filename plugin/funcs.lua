-- Function to do helpfully print lua vars
P = function (val)
  print(vim.inspect(val))
  return val
end

-- Function to reload a lua module
RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

R = function (name)
  RELOAD(name)
  return require(name)
end
