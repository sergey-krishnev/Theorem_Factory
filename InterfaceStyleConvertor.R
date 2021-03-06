library(gWidgets)
library(gWidgetstcltk)
options(guiToolkit="tcltk")

#��������� � ������� ����������
setwd("D:/Program Files/Theorem Factory/style_converter/style_templates")
input_names_style <- dir()
#������ ���������� ����
win_style <- gbasicdialog("Style Converter v.0.2 by Sergey Krishnev",visible = F,do.buttons=FALSE)

#���������� ������� ������
style_group <- ggroup(container = win_style)

#���� ������ ���������� ���������
setwd("D:/Program Files/Theorem Factory/text_input_documents")
input_name_docstyle <- dir()

input_style_template <- gframe("Document",container = style_group,horizontal = F)
glabel("Choose the document to edit it:",container = input_style_template)
style_template <- gcombobox(input_name_docstyle, container = input_style_template)

#�������� ������
choose_style_template <- gframe("Styles",container = style_group,horizontal = F)
glabel("Choose the type of style:",container = choose_style_template)
type_style_template <- gcombobox(input_names_style, container = choose_style_template)

#����� �����
choosename_newdocstyle <- gframe("Name of new document",container = win_style,horizontal = F)
glabel("Write the name (without extension):",container = choosename_newdocstyle)
name_newdocstyle <- gedit("", container = choosename_newdocstyle)

#������ Start
gbutton("In other style!", container = win_style,handler = function(h,...) {
  selected_style_document <- svalue(style_template)
  write.table(selected_style_document, "D:/Program Files/Theorem Factory/choice/selected_style_document.txt")
  selected_type_style <- svalue(type_style_template)
  write.table(selected_type_style, "D:/Program Files/Theorem Factory/choice/selected_type_style.txt")
  name_ofnewdocstyle <- svalue(name_newdocstyle)
  write.table(name_ofnewdocstyle, "D:/Program Files/Theorem Factory/choice/name_ofnewdocstyle.txt")
  gmessage(paste0("Style is edited!"))
  setwd("D:/Program Files/Theorem Factory")
  source("CreatingStyleConvertor.R")
  source("SelfStylizing.R")
})

#������ Cancel
gbutton("Cancel", container = win_style,handler = function(h,...) {
  dispose(win_style)
})


#�������� ����
visible(win_style, set = T)