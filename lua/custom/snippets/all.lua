-- Clear the session to allow for hot reloading
require("luasnip.session.snippet_collection").clear_snippets "all"

local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node

local date = function() return {os.date('%Y-%m-%d')} end
local isodatetime = function() return {os.date('%Y-%m-%d %H:%M:%S%z')} end

ls.add_snippets("all", {
  s({trig = "<date", name = "Date", desc = "(date) \"YYY-MM-DD\"",}, {
    f(date)
  }),
  s({trig = "<isodatetime", name = "ISO datetime", desc = "ISO format datetime",}, {
    f(isodatetime)
  }),
})
