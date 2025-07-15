-- Clear the session to allow for hot reloading
require("luasnip.session.snippet_collection").clear_snippets "cpp"

local ls = require("luasnip")
local utils = require("custom.snippets.common.snippets_utils")

local s = ls.snippet
local t =ls.text_node
local nl = utils.new_line

ls.add_snippets("puml", {
  s({trig = "<sequence", name = "Sequence", desc = "sequence diagram",}, {
    t"@startuml", nl(),
    t"Alice -> Bob: Authentication Request", nl(),
    t"Bob -> Alice: Authentication Response", nl(),
    t"@enduml", nl(),
  }),
})
