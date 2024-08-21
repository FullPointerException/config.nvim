-- Clear the session to allow for hot reloading
--require("luasnip.session.snippet_collection").clear_snippets "javascript"

local ls = require("luasnip")
local utils = require("custom.snippets.common.snippets_utils")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local nl = utils.new_line

ls.add_snippets("javascript", {
  s({trig = "switch", name = "switch", desc = "switch / case",}, {
    t"switch(", i(1, "expression", {key = "i1"}), t") {", nl(),
  }),
})
