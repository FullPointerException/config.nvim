-- Clear the session to allow for hot reloading
require("luasnip.session.snippet_collection").clear_snippets "cpp"

local ls = require("luasnip")
local utils = require("custom.snippets.common.snippets_utils")
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local i = ls.insert_node
local nl = utils.new_line

-- TODO commonize
local function noop(args)
  return args[1][1]
end

local function capitalize(args)
  local str = args[1][1]
  return (str:gsub("^%l", string.upper))
end

-- Standard c++ stuff
-- Qt stuff
ls.add_snippets("cpp", {
  -- Q_PROPERTY things
  s({trig = "qclass", name = "Qt Class", desc = "class inheriting QObject",}, {
    t"class ", f(utils.classname), t" :public", nl(),
  }),
  s({trig = "qpc", name = "Q_PROPERTY CONSTANT", desc = "Q_PROPERTY for constant property",}, {
    t"Q_PROPERTY(", i(1, "Type", {key = "i1"}), t" ", i(2, "name", {key = "i2"}), t" READ ", f(noop, {2}), t" CONSTANT);", nl(),
    f(noop, {1}), t" ", f(noop, {2}), t"() const;", nl(),
  }),
  s({trig = "qpro", name = "Q_PROPERTY READ ONLY", desc = "Q_PROPERTY for read only property",}, {
    t"Q_PROPERTY(", i(1, "Type", {key = "i1"}), t" ", i(2, "name", {key = "i2"}), t" READ ", f(noop, {2}), t" NOTIFY ", f(noop, {2}), t"Changed);", nl(),
    f(noop, {1}), t" ", f(noop, {2}), t"() const;", nl(),
    t"void ", f(noop, {2}), t"Changed();", nl(),
  }),
  s({trig = "qprw", name = "Q_PROPERTY READ WRITE", desc = "Q_PROPERTY for read/write property", }, {
    t"Q_PROPERTY(", i(1, "Type", {key = "i1"}), t" ", i(2, "name", {key = "i2"}), t" READ ", f(noop, {2}), t" WRITE set", f(capitalize, {2}), t" NOTIFY ", f(noop, {2}), t"Changed);", nl(),
    f(noop, {1}), t" ", f(noop, {2}), t"() const;", nl(),
    t"void set", f(capitalize, {2}), t"(", f(noop, {1}), t" new", f(capitalize, {2}), t");", nl(),
    t"void ", f(noop, {2}), t"Changed();", nl(),
  }),
  -- TODO make CLASSNAME be dynamic
  s({trig = "QAbstractListModel", name = "QAbstractListModel", desc = "QAbstractListModel",}, {
    t"#pragma once", nl(),
    nl(),
    t"#include <QAbstractListModel>", nl(),
    t"#include <QObject>", nl(),
    nl(),
    t"class ", t"CLASSNAME", t" : public QAbstractListModel", nl(),
    t"{", nl(),
    t"\tQ_OBJECT", nl(),
    t"\tQML_ELEMENT", nl(),
    t"\tQML_UNCREATABLE(\"Cannot create ", t"CLASSNAME", t" in QML\")", nl(),
    nl(),
    t"public:", nl(),
    t"\tenum ", t"CLASSNAME", t"Roles {", nl(),
    t"\t\t", t"ROLE1", t" = Qt::UserRole,", nl(),
    t"\t\t", t"ROLE2,", nl(),
    t"\t\t};", nl(),
    t"\tQ_ENUM(", t"CLASSNAME", t"Roles);", nl(),
    nl(),
    t"\t", t"CLASSNAME", t"();", nl(),
    t"\t~", t"CLASSNAME", t"() override;", nl(),
    nl(),
    t"\tint rowCount(const QModelIndex& parent = QModelIndex()) const override;", nl(),
    t"\tQVariant data(const QModelIndex& index, int role) const override;", nl(),
    t"\tQHash<int, QByteArray> roleNames() const override;", nl(),
    nl(),
    t"private:", nl(),
    nl(),
    t"};", nl(),
  }),
})

