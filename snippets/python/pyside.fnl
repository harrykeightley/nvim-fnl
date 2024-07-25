(local ls (require :luasnip))
(local {:snippet s
        :snippet_node sn
        :text_node t
        :insert_node i
        :function_node f
        :dynamic_node d} ls)

(local {: fmt : fmta} (require :luasnip.extras.fmt))
(local {: rep} (require :luasnip.extras))

[(s :psim [(t ["from PySide6 import QtCore as qtc"
               "from PySide6 import QtGui as qtg"
               "from PySide6 import QtWidgets as qtw"])])
 (s :psm (fmt "import sys

if __name__ == '__main__':
  app = qtw.QApplication(sys.argv)

  widget = {}()
  widget.show()

  sys.exit(app.exec())
  " (i 1)))]
