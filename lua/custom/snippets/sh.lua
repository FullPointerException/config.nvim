-- Clear the session to allow for hot reloading
require("luasnip.session.snippet_collection").clear_snippets "sh"

local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node

ls.add_snippets("sh", {
  s({trig = "<strict", name = "Bash Strict Mode", des = "Bash strict mode",}, {
    t"set -euo pipefail",
  }),
})
