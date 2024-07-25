-- [nfnl] Compiled from snippets/python/pyside.fnl by https://github.com/Olical/nfnl, do not edit.
local ls = require("luasnip")
local _local_1_ = ls
local s = _local_1_["snippet"]
local sn = _local_1_["snippet_node"]
local t = _local_1_["text_node"]
local i = _local_1_["insert_node"]
local f = _local_1_["function_node"]
local d = _local_1_["dynamic_node"]
local _local_2_ = require("luasnip.extras.fmt")
local fmt = _local_2_["fmt"]
local fmta = _local_2_["fmta"]
local _local_3_ = require("luasnip.extras")
local rep = _local_3_["rep"]
return {s("psim", {t({"from PySide6 import QtCore as qtc", "from PySide6 import QtGui as qtg", "from PySide6 import QtWidgets as qtw"})}), s("psm", fmt("import sys\n\nif __name__ == '__main__':\n  app = qtw.QApplication(sys.argv)\n\n  widget = {}()\n  widget.show()\n\n  sys.exit(app.exec())\n  ", i(1)))}
