-- Clear the session to allow for hot reloading
require("luasnip.session.snippet_collection").clear_snippets "all"

local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local t = ls.text_node

local date = function() return {os.date('%Y-%m-%d')} end
local time = function() return {os.date('%H:%M')} end
local datetime = function() return {os.date('%Y-%m-%d %H:%M')} end
local isodatetime = function() return {os.date('%Y-%m-%d %H:%M:%S%z')} end

ls.add_snippets("all", {
  s({trig = "<date", name = "Date", desc = "(date) \"YYYY-MM-DD\"",}, {
    f(date)
  }),
  s({trig = "<time", name = "Time", desc = "(time) \"hh:mm\"",}, {
    f(time)
  }),
  s({trig = "<datetime", name = "datetime", desc = "(datetime) \"(YYYY-MM-DD\"",}, {
    f(datetime)
  }),
  s({trig = "<isodatetime", name = "ISO datetime", desc = "ISO format datetime",}, {
    f(isodatetime)
  }),
  s({trig = "<lorem", name = "Lorem Ipsum", desc = "Filler text",}, {
    t"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  }),
})
