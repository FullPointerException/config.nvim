-- Clear the session to allow for hot reloading
require("luasnip.session.snippet_collection").clear_snippets "cpp"

local ls = require("luasnip")
local utils = require("custom.snippets.common.snippets_utils")
local s = ls.snippet
local t = ls.text_node
local d = ls.dynamic_node
local f = ls.function_node
local nl = utils.new_line

-- Standard c++ stuff
-- TODO switch / case


-- Qt stuff
ls.add_snippets("cpp", {
  s({trig = "qclass", name = "Qt Class", desc = "class inheriting QObject",}, {
    t"class ", f(utils.classname), t" :public", nl(),
  }),
})

-- TODO switch/case

--[[ TODO QAbstractListModel
#pragma once

#include <QAbstractListModel>
#include <QObject>

class CLASSNAME : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT
    QML_UNCREATABLE("Cannot create CLASSNAME in QML")

public: 
    enum CLASSNAMERoles {
        ROLE1 = Qt::UserRole,
        ROLE2,
    };
    Q_ENUM(CLASSNAMERoles);

    CLASSNAME();
    ~CLASSNAME() override;

    int rowCount(const QModelIndex& parent = QModelIndex()) const override;
    QVariant data(const QModelIndex& index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

private:
};

]]--

