-- Clear the session to allow for hot reloading
require("luasnip.session.snippet_collection").clear_snippets "bash"

local ls = require("luasnip")
--local utils = require("custom.snippets.common.snippets_utils")
local s = ls.snippet
local t = ls.text_node
local d = ls.dynamic_node
--local nl = utils.new_line

-- Qt stuff
ls.add_snippets("cpp", {
  s({trig = "qclass", name = "Qt Class", desc = "class inheriting QObject",}, {
    --t"class ", d(1, function(args, snip) return "TODO" end), t":public ", nl(),
  }),
})
