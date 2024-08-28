-- Clear the session to allow for hot reloading
require("luasnip.session.snippet_collection").clear_snippets "cpp"

local ls = require("luasnip")
local utils = require("custom.snippets.common.snippets_utils")
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local nl = utils.new_line

-- Standard c++ stuff
-- Qt stuff
ls.add_snippets("cpp", {
  -- TODO FINISH THIS ONE
  s({trig = "qclass", name = "Qt Class", desc = "class inheriting QObject",}, {
    t"class ", f(utils.classname), t" :public", nl(),
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
    t"\tQML_UNCREATABLE(\"Cannot create ", t"CLASSNAME", " in QML)", nl(),
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

