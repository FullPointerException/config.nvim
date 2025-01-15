-- Clear the session for hot reloading
require("luasnip.session.snippet_collection").clear_snippets "c"

local ls = require("luasnip")
local utils = require("custom.snippets.common.snippets_utils")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local nl = utils.new_line

ls.add_snippets("c", {
  s({trig = "switch", name = "switch", desc = "switch / case",}, {
    t"switch(", i(1, "expression", {key = "i1"}), t") {", nl(),
    t"\tcase ", i(2, "match", {key = "i2"}), t": {", nl(),
    t"\t\t", i(3, "code", {key = "i3"}), nl(),
    t"\t\tbreak;", nl(),
    t"\t}", nl(),
    t"\t", i(0, "", {key = "i0"}), nl(),
    t"\tdefault: {", nl(),
    t"\t\t", i(4, "code", {key = "i4"}), nl(),
    t"\t\tbreak;", nl(),
    t"\t}", nl(),
    t"}", nl(),
  }),
  s({trig = "switchr", name = "switch return", desc = "switch / case",}, {
    t"switch(", i(1, "expression", {key = "i1"}), t") {", nl(),
    t"\tcase ", i(2, "match", {key = "i2"}), t": {", nl(),
    t"\t\treturn ", i(3, "code", {key = "i3"}), nl(),
    t"\t}", nl(),
    t"\t", i(0, "", {key = "i0"}), nl(),
    t"\tdefault: {", nl(),
    t"\t\treturn ", i(4, "code", {key = "i4"}), nl(),
    t"\t}", nl(),
    t"}", nl(),
  }),
})

